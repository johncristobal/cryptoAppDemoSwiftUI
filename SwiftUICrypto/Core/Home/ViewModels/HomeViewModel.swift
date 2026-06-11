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
    
    @Published var allCoins: [CoinModel] = []
    @Published var portafolioCoins: [CoinModel] = []

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
    }
}
