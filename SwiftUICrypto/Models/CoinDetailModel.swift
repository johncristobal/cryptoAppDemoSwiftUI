
//
//  CoinDetailView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 25/06/26.
//

import Foundation

struct CoinDetail: Codable {
    let id: String
    let symbol: String
    let name: String
    let webSlug: String
    let assetPlatformId: String?
    let platforms: [String: String]
    let detailPlatforms: [String: DetailPlatform]
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let previewListing: Bool
    let hasSupplyBreakdown: Bool
    let description: DescriptionCoin
    let links: CoinLinks
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case assetPlatformId = "asset_platform_id"
        case platforms
        case detailPlatforms = "detail_platforms"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case previewListing = "preview_listing"
        case hasSupplyBreakdown = "has_supply_breakdown"
        case description
        case links
    }
    
    struct DetailPlatform: Codable {
        let decimalPlace: Int?
        let contractAddress: String
        
        enum CodingKeys: String, CodingKey {
            case decimalPlace = "decimal_place"
            case contractAddress = "contract_address"
        }
    }
    
    struct CoinLinks: Codable {
        let homepage: [String]
        let subredditUrl: String?
        let reposUrl: ReposUrl
        
        enum CodingKeys: String, CodingKey {
            case homepage
            case subredditUrl = "subreddit_url"
            case reposUrl = "repos_url"
        }
        
        struct ReposUrl: Codable {
            let github: [String]
            let bitbucket: [String]
        }
    }
    
    struct CoinImage: Codable {
        let thumb: String?
        let small: String?
        let large: String?
    }
    
    struct DescriptionCoin: Codable {
        let en: String?
    }
}
