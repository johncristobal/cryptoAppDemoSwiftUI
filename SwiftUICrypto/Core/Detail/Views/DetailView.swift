//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 24/06/26.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    @State var showDescription = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        self._vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.top, 10)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                                        
                    descriptionText
                    overviewGrid
                    additionalTitle
                    
                    Divider()
                    additionalGrid
                    
                    VStack {
                        if let website = vm.webSite, let url = URL(string: website) {
                            Link("Wbesite", destination: url)
                        }
                    }
                    .accentColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navItem
            }
        }
    }
}

#Preview {
    DetailView(coin: .ethereumCoin)
}

extension DetailView {
    
    private var navItem: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewS) { stat in
                    StatisticsView(statistics: stat)
                }
            }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additinoalS) { stat in
                    StatisticsView(statistics: stat)
                }
            }
    }
    
    private var descriptionText: some View {
        ZStack {
            if let description = vm.coinDes, !description.isEmpty {
                VStack(alignment: .leading) {
                    Text(description)
                        .lineLimit(showDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation {
                            showDescription.toggle()
                        }
                    } label: {
                        Text(showDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .padding(.vertical, 4)
                    }
                    .accentColor(Color.theme.accent)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
