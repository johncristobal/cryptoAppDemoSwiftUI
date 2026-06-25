//
//  CoinDataService.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 11/06/26.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&names=Bitcoin&symbols=btc&category=layer-1&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)!
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
