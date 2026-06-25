//
//  MarketDataService.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 19/06/26.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    
    var marketSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketSubscription = NetworkingManager.download(url: url)!
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] data in
                self?.marketData = data.data
                self?.marketSubscription?.cancel()
            })
    }
}
