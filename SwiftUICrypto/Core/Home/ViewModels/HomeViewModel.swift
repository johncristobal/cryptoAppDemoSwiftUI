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
    @Published var isLoading = false
    
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
        
        // updates database
        $allCoins
            .combineLatest(portafolioService.$portafolio)
            .map(mapAllCoinsToPortafolio)
            .sink { [weak self] coins in
                self?.portafolioCoins = coins
            }
            .store(in: &cancellables)
        
        // ipdate market data
        marketataService.$marketData
            .combineLatest($portafolioCoins)
            .map(appendMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
                self?.isLoading = false
            }
            .store(in: &cancellables)

    }
    
    func updatePortafolio(coin: CoinModel, amount: Double) {
        portafolioService.updatePortafolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true

        coinDataService.getCoins()
        marketataService.getData()
        HapticManager.play(type: .success)
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
    
    private func mapAllCoinsToPortafolio(coins: [CoinModel], portafolio: [PortafolioEntity]) -> [CoinModel] {
        coins
            .compactMap { coin -> CoinModel? in
                guard let entityName = portafolio.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entityName.amout)
            }
    }
    
    private func appendMarketData(model: MarketDataModel?, portafoliocoins: [CoinModel]) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        guard let data = model else { return stats }
        
        let marketCap = StatisticsModel(title: "Market cap", value: data.marketCap, percentage: data.marketCapChangePercentage24hUsd)
        let volume = StatisticsModel(title: "24 Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portafolioValue = portafoliocoins
            .map( {$0.currentHoldingsValue } )
            .reduce(0, +)
        
        let previousValue = portafoliocoins
            .map { coin -> Double in
                let current = coin.currentHoldingsValue
                let change = coin.priceChangePercentage24h / 100.0
                
                let previous = current / (1 + change)
                return previous
            }
            .reduce(0, +)
        let percentageChange = ((portafolioValue - previousValue) / previousValue) * 100
        
        let portafolio = StatisticsModel(title: "Portafolio volumne", value: portafolioValue.asCurrencyWith2Decimals(), percentage: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portafolio
        ])
     
        return stats
    }
}
