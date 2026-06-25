//
//  DetailViewModel.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 25/06/26.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var coin: CoinModel
    private let service: DetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var overviewS:[StatisticsModel] = []
    @Published var additinoalS:[StatisticsModel] = []
    
    init (coin: CoinModel) {
        self.coin = coin
        service = DetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        service.$coinDetail
            .combineLatest($coin)
            .map(dataToStatistics)
            .sink { [weak self] arrays in
                self?.overviewS = arrays.0
                self?.additinoalS = arrays.1
            }
            .store(in: &cancellables)
    }
    
    private func dataToStatistics(details: CoinDetail?, coinModel: CoinModel) -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
        // overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priveChange = coinModel.priceChangePercentage24h
        let priceStat = StatisticsModel(title: "Current price", value: price, percentage: priveChange)
        
        let marketCap = coinModel.marketCap.formattedWithAbbreviations()
        let marketChange = coinModel.marketCapChangePercentage24h
        let marketStat = StatisticsModel(title: "Market Cap", value: marketCap, percentage: marketChange)
        
        let rank = coinModel.rank
        let rankStat = StatisticsModel(title: "Rank", value: rank.description)
        
        let volume = coinModel.totalVolume.formattedWithAbbreviations()
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticsModel] = [
             priceStat, marketStat, rankStat, volumeStat
        ]
        
        // additiaontl
        let high = coinModel.high24h.asCurrencyWith6Decimals()
        let highStat = StatisticsModel(title: "24 high", value: high)

        let low = coinModel.low24h.asCurrencyWith6Decimals()
        let lowStat = StatisticsModel(title: "24 low", value: low)

        let additionalArray: [StatisticsModel] = [
            highStat, lowStat
        ]
        
        return (overviewArray, additionalArray)
    }
}
