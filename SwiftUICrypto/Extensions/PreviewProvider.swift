//
//  PreviewProvider.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/9/21.
//

import Foundation
import SwiftUI

public extension Preview {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

public class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
//    let homeVM = HomeViewModel()
//    
//    let stat1 = StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
//    let stat2 = StatisticModel(title: "Total Volume", value: "$1.23Tr")
//    let stat3 = StatisticModel(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)
    
}
