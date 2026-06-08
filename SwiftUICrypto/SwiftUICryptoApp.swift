//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 05/06/26.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
