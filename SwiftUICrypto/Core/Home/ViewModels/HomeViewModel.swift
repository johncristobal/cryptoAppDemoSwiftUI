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
    
    @Published var sortOption: SortOption = .holding
    
    private let coinDataService = CoinDataService()
    private let marketataService = MarketDataService()
    private let portafolioService = PortafolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holding, holdingReversed, price, priceReversed
    }
    
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
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSort)
            .sink { [weak self] values in
                self?.allCoins = values
            }
            .store(in: &cancellables)
        
        // updates database
        $allCoins
            .combineLatest(portafolioService.$portafolio)
            .map(mapAllCoinsToPortafolio)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.portafolioCoins = self.sortPortafolioCoins(coins: coins)
            }
            .store(in: &cancellables)
        
        // update market data
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
    
    private func filterAndSort(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel]{
        var filterCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &filterCoins)
        return filterCoins
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
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
            case .price:
                coins.sort(by: {$0.currentPrice > $1.currentPrice })
            case .priceReversed:
                coins.sort(by: {$0.currentPrice < $1.currentPrice })
        case .rank, .holding:
                coins.sort(by: {$0.rank < $1.rank })
//                return coins.sorted { coin1, coin2 -> Bool in
//                    return coin1.rank < coin2.rank
//                }
        case .rankReversed, .holdingReversed:
                coins.sort(by: {$0.rank > $1.rank })
        }
    }
    
    private func sortPortafolioCoins(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holding:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue })
        default :
            return coins
        }
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
