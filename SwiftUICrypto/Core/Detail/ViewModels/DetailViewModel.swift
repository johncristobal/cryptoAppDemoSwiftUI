//
//  DetailViewModel.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 25/06/26.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let service: DetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init (coin: CoinModel) {
        service = DetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        service.$coinDetail
            .sink { detail in
                print("DETAIL")
                print(detail)
            }
            .store(in: &cancellables)
    }
}
