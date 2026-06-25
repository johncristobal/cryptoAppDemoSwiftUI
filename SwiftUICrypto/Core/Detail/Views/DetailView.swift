//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 24/06/26.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self._vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: .ethereumCoin)
}
