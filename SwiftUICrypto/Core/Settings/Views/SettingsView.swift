//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 27/06/26.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://github.com/johncris/SwiftUICrypto")!
    let youtubeURL = URL(string: "https://github.com/johncris/SwiftUICrypto")!
    let coffeURL = URL(string: "https://github.com/johncris/SwiftUICrypto")!
    
    
    var body: some View {
        List {
            section1
            section1
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                XMarkButton()
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var section1: some View {
        Section(header: Text("Swift")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                Text("This app was made by")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("youtbe 📀", destination: youtubeURL)
            Link("coffe ☕️", destination: coffeURL)
        }
    }
}
