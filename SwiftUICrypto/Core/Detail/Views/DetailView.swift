//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 24/06/26.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("coin \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: .ethereumCoin)
}
