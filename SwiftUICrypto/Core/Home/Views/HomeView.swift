//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 08/06/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortafolio: Bool = false
    @State private var showPortafolioView: Bool = false
    
    @State private var selectedCoin: CoinModel?
    @State private var showDetail = false
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortafolioView) {
                    PortafolioView()
                        .environmentObject(vm)
                }
            
            // content
            VStack {
                homeHeader
                
                HomeStatsView(showPortafolio: $showPortafolio)
                SearchBarView(searchText: $vm.searchText)
                
                colulmnTitles
                
                if !showPortafolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortafolio {
                    portafolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .navigationDestination(isPresented: $showDetail) {
                if let coin = selectedCoin {
                    DetailView(coin: coin)
                }
            }
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(
                iconName: showPortafolio ? "plus" : "info"
            )
            .animation(.none)
            .onTapGesture {
                showPortafolioView.toggle()
            }
            .background(
                CircleButtonAnimationView(animate: $showPortafolio)
            )
            Spacer()
            Text(showPortafolio ? "Portafolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(
                    degrees: showPortafolio ? 180 : 0)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortafolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        selectedCoin = coin
                        showDetail = true
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portafolioCoinsList: some View {
        List {
            ForEach(vm.portafolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        selectedCoin = coin
                        showDetail = true
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var colulmnTitles: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortafolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holding || vm.sortOption == .holdingReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holding ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holding ? .holdingReversed : .holding
                    }
                }
            }
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(HomeViewModel())
}
