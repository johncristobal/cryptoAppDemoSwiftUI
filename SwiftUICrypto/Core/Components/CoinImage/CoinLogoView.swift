//
//  CoinLogoView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 23/06/26.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview("Light", traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: .ethereumCoin)
        .preferredColorScheme(.light)
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: .ethereumCoin)
        .preferredColorScheme(.dark)
}
