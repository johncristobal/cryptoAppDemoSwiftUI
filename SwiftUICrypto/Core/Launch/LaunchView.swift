//
//  LaunchView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 27/06/26.
//

import SwiftUI

struct LaunchView: View {
    
    @State var loadingText = "Loading..."
    @State var showText = false
    @Binding var showLauncView: Bool
    
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showText {
                    Text(loadingText)
                        .font(.headline)
                        .foregroundStyle(Color.launch.accent)
                        .fontWeight(.heavy)
                        .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showText.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation {
                    showLauncView = false
                }
            })
        }
    }
}

#Preview {
    LaunchView(showLauncView: .constant(true))
}
