//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 10/06/26.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticsModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portafolioCoins: [CoinModel] = []

    @Published var searchText : String = ""
    
    private let coinDataService = CoinDataService()
    private let marketataService = MarketDataService()
    private let portafolioService = PortafolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addsubscribers()
    }
    
    func addsubscribers() {
        coinDataService.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)

        // combinamos publishers, cuando cambien uno, se ejecuta
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] values in
                self?.allCoins = values
            }
            .store(in: &cancellables)
        
        marketataService.$marketData
            .map(appendMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellables)
        
        // updates database
        $allCoins
            .combineLatest(portafolioService.$portafolio)
            .map { (coins, portafolio) -> [CoinModel] in
                coins
                    .compactMap { coin -> CoinModel? in
                        guard let entityName = portafolio.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entityName.amout)
                    }
            }
            .sink { [weak self] coins in
                self?.portafolioCoins = coins
            }
            .store(in: &cancellables)
    }
    
    func updatePortafolio(coin: CoinModel, amount: Double) {
        portafolioService.updatePortafolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lower = text.lowercased()
        let filter = coins.filter { coin in
            return coin.name.lowercased().contains(lower) ||
            coin.symbol.lowercased().contains(lower) ||
            coin.id.lowercased().contains(lower)
        }
        
        return filter
    }
    
    private func appendMarketData(model: MarketDataModel?) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        guard let data = model else { return stats }
        
        let marketCap = StatisticsModel(title: "Market cap", value: data.marketCap, percentage: data.marketCapChangePercentage24hUsd)
        let volume = StatisticsModel(title: "24 Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        let portafolio = StatisticsModel(title: "Portafolio volumne", value: "$0.00", percentage: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portafolio
        ])
     
        return stats
    }
}
