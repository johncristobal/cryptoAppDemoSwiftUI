//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 05/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 40) {
                Text("Accen Color")
                    .foregroundColor(Color.theme.accent)
                Text("Seondary color")
                    .foregroundColor(Color.theme.secondaryText)
                Text("Red color")
                    .foregroundColor(Color.theme.red)
                Text("Green color")
                    .foregroundColor(Color.theme.greenTheme)
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
