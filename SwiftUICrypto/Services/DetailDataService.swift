//
//  DetailDataService.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 25/06/26.
//

import Foundation

import Combine

class DetailDataService {
    
    @Published var coinDetail: CoinDetail?
    
    var coinSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getDetail()
    }
    
    func getDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false&include_categories_details=false") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)!
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] detail in
                self?.coinDetail = detail
                self?.coinSubscription?.cancel()
            })
    }
}

