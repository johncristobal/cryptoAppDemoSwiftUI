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
    
    @Published var statistics: [StatisticsModel] = [
        StatisticsModel(title: "Market cap", value: "$12.58", percentage: 25.34),
        StatisticsModel(title: "Market cap", value: "$12.58", percentage: 25.34),
        StatisticsModel(title: "Market cap", value: "$12.58", percentage: 25.34)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portafolioCoins: [CoinModel] = []

    @Published var searchText : String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addsubscribers()
    }
    
    func addsubscribers() {
        dataService.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)

        // combinamos publishers, cuando cambien uno, se ejecuta
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] values in
                self?.allCoins = values
            }
            .store(in: &cancellables)
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
}
