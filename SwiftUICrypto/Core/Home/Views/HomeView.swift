//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 08/06/26.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortafolio: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
                .ignoresSafeArea()
            
            // content
            VStack {
                homeHeader
                Spacer(minLength: 0)
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
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}
