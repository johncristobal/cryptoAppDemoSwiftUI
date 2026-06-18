//
//  StatisticsModel.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 18/06/26.
//

import Foundation

struct StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentage: Double?
    
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}

extension StatisticsModel {
    public static let stat1 = StatisticsModel(title: "Market cap", value: "$12.58", percentage: 25.34)
    public static let stat2 = StatisticsModel(title: "Total Vol", value: "$1.23")
    public static let stat3 = StatisticsModel(title: "Portafolio value", value: "$1.23", percentage: -32.23)
}
