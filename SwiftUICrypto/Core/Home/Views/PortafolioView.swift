//
//  PortafolioView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 23/06/26.
//

import SwiftUI

struct PortafolioView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State var selectedCoin: CoinModel? = nil
    @State var quantityText: String = ""
    @State var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if let coin = selectedCoin {
                        portafolioInput(for: coin)
                    }
                }
                .navigationTitle("Edit")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        tralingButton
                    }
                })
            }
        }
    }
}

#Preview {
    PortafolioView()
        .environmentObject(HomeViewModel())
}

extension PortafolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture(perform: {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        })
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id
                                    ? Color.theme.greenTheme
                                    : Color.clear,
                                    lineWidth: 1
                                )
                        )
                }
            }
            .frame(height: 120)
            .padding(4)
        }
    }
    
    private func portafolioInput(for coin: CoinModel) -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(coin.symbol.uppercased())")
                Spacer()
                Text(coin.currentPrice.asCurrencyWith6Decimals())
            }
            Divider()
            HStack {
                Text("Amount holding")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value")
                Spacer()
                Text(getCurrentValue(for: coin).asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var tralingButton : some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButton()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))
                ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButton() {
        guard let coin = selectedCoin else { return }
        
        // save
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSeleccted()
        }
        
        // hide key
        UIApplication.shared.endEditing()
        
        // hide check
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeIn) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSeleccted() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private func getCurrentValue(for coin: CoinModel) -> Double {
        if let quanity = Double(quantityText) {
            return quanity * coin.currentPrice
        }
        return 0
    }
}

