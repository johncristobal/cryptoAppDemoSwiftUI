//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 05/06/26.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLauncView = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLauncView {
                        LaunchView(showLauncView: $showLauncView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
