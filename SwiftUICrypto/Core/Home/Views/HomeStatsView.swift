//
//  HomeStatsView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 18/06/26.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortafolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { statistic in
                StatisticsView(statistics: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: showPortafolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortafolio: .constant(false))
        .environmentObject(HomeViewModel())
}
