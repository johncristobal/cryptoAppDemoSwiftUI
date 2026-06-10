//
//  CoinModel.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 08/06/26.
//

import Foundation

/*
 URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&names=Bitcoin&symbols=btc&category=layer-1&price_change_percentage=1h
 */

struct CoinModel: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Double?
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24h: Double
    let low24h: Double
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let marketCapChange24h: Double
    let marketCapChangePercentage24h: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double
    let athDate: String
    let atl: Double
    let atlChangePercentage: Double
    let atlDate: String
    let roi: ROI?
    let lastUpdated: String
    let priceChangePercentage24hInCurrency: Double?
    let currentHoldings: Double?

    struct ROI: Codable {
        let times: Double
        let currency: String
        let percentage: Double
    }

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }

    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24h: high24h,
            low24h: low24h,
            priceChange24h: priceChange24h,
            priceChangePercentage24h: priceChangePercentage24h,
            marketCapChange24h: marketCapChange24h,
            marketCapChangePercentage24h: marketCapChangePercentage24h,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            roi: roi,
            lastUpdated: lastUpdated,
            priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency,
            currentHoldings: amount
        )
    }
}

extension CoinModel {
    public static let ethereumCoin = CoinModel(
       id: "ethereum",
       symbol: "eth",
       name: "Ethereum",
       image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
       currentPrice: 1696.22,
       marketCap: 204707750079,
       marketCapRank: 2,
       fullyDilutedValuation: 204707750079,
       totalVolume: 18055439802,
       high24h: 1712.73,
       low24h: 1632.55,
       priceChange24h: 63.67,
       priceChangePercentage24h: 3.90004,
       marketCapChange24h: 7637994550,
       marketCapChangePercentage24h: 3.87578,
       circulatingSupply: 120684490.995401,
       totalSupply: 120684490.995401,
       maxSupply: nil,
       ath: 4946.05,
       athChangePercentage: -65.7055,
       athDate: "2025-08-24T19:21:03.333Z",
       atl: 0.432979,
       atlChangePercentage: 391656.45106,
       atlDate: "2015-10-20T00:00:00.000Z",
       roi: CoinModel.ROI(
        times: 34.72243700539618,
        currency: "btc",
        percentage: 3472.243700539618
       ),
       lastUpdated: "2026-06-08T22:09:23.387Z",
       priceChangePercentage24hInCurrency: 3.9000381250323577,
       currentHoldings: 2.0)
}
