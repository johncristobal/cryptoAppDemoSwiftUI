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
    let sparkLine: SparkLine?

    struct ROI: Codable {
        let times: Double
        let currency: String
        let percentage: Double
    }

    struct SparkLine: Codable {
        let price: [Double]
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
        case sparkLine = "sparkline_in_7d"
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
            currentHoldings: amount,
            sparkLine: nil
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
       currentHoldings: 2.0,
       sparkLine: SparkLine(price: [
        62577.202538005855,
        62729.45075831364,
        63175.98074164291,
        63148.3861884272,
        63159.432954581534,
        62934.94732450514,
        63148.481990645334,
        63042.82637725984,
        62959.09109524105,
        63195.2284343016,
        63012.32825754403,
        63266.15709765246,
        63513.65867862926,
        63496.158339193826,
        63510.90036668932,
        63304.890670990404,
        63379.40256078363,
        63502.82002490304,
        63616.95037618205,
        63681.380836533914,
        63621.05910459087,
        63351.08268255933,
        63679.2308895568,
        63606.56270077006,
        63619.35732609742,
        63585.73091015975,
        63362.43392790553,
        63894.21615280764,
        64062.833768911434,
        63943.04118715367,
        63784.922563789114,
        63725.97689907947,
        63853.1671355726,
        63848.028045326435,
        63934.59027569325,
        64230.359598341056,
        64240.23278038838,
        64217.24097636916,
        64191.186350054384,
        64186.60079332979,
        64362.421773695045,
        64210.079461463036,
        64182.552305195,
        64221.92326540055,
        64127.25467229687,
        63926.36278043242,
        64135.487232232656,
        64279.45257624553,
        64075.9827674072,
        64121.742128811944,
        64040.79854664274,
        64049.07486151821,
        64164.14040212614,
        64073.09375345309,
        64106.015938391814,
        64104.840705353294,
        64143.29569438601,
        63752.068770525155,
        63736.59228664353,
        63730.37118386725,
        63231.86958363731,
        63773.22019447084,
        64510.52230449925,
        64200.788144693484,
        63898.787155602484,
        64016.58324267139,
        64154.72982336872,
        63940.26315995606,
        64134.651134027,
        64087.37042490323,
        64055.179036193535,
        64068.498384986066,
        64594.71350884732,
        65095.257315744195,
        65468.626564180355,
        64888.927469478935,
        64754.92452119641,
        64683.704578473276,
        64556.49952209388,
        64301.39877649407,
        64417.748318432954,
        64365.9175955822,
        64235.021031055294,
        63911.612718239056,
        63957.19561383976,
        64045.666767229544,
        64079.82103359411,
        64144.39979492271,
        63980.98741876507,
        63621.26042010823,
        63313.7269410536,
        62866.90848700344,
        62850.76814022467,
        62311.40037519842,
        62307.34214427159,
        62264.18908247069,
        62451.49737098857,
        62199.8784487437,
        62383.94741826511,
        62457.865612986134,
        62378.52994283749,
        62492.81701127148,
        62300.737372444346,
        62171.87002961892,
        62310.62864515332,
        62385.33941347201,
        62530.759849035516,
        62515.95646051559,
        62651.93474257838,
        62912.97023760417,
        62883.37584853357,
        62583.0454660447,
        62676.59157469255,
        62703.951669706556,
        62802.23166347988,
        62699.01945275507,
        62568.95078726398,
        62716.04032481007,
        62621.29389792389,
        62379.401309585366,
        62815.96886427302,
        62538.57860514398,
        61236.55534272521,
        60985.864493824105,
        60204.220327509334,
        59783.05042276664,
        59297.73643929386,
        59507.187984197044,
        59822.24825588187,
        60882.548735749966,
        61005.378953134474,
        60783.200878396405,
        60990.53863518005,
        60664.90692436006,
        60812.426404174934,
        60629.714711165805,
        60788.38575979891,
        61257.61278932525,
        61534.43462777755,
        61646.00687766538,
        61816.442509036395,
        61606.905269718525,
        61652.90431812403,
        61211.78155908992,
        61185.54992485836,
        61114.65746062846,
        58188.668886715604,
        59419.45155775679,
        59513.72747967234,
        59234.5777533372,
        59534.099860815295,
        59430.91825964714,
        59237.365253537,
        59312.805434743896,
        60111.69113616151,
        59787.08233594131,
        59712.618061582114,
        59589.363566722495,
        59299.072111513124,
        58482.96476980456,
        59836.297717503796,
        59813.84530916572,
        59869.425120800624,
        60237.0568540939,
        60481.35722924747,
        60152.35271713132,
        59633.32449414534,
        59215.19340895525,
        59316.01978220941
    ])
    )
}
