//
//  StatisticsView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 18/06/26.
//

import SwiftUI

struct StatisticsView: View {
    
    let statistics: StatisticsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistics.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(statistics.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect(
                        Angle(degrees: (statistics.percentage ?? 0) >= 0 ? 0 : 180)
                    )
                
                Text(statistics.percentage?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                (statistics.percentage ?? 0) >= 0
                ? Color.theme.greenTheme
                : Color.theme.red
            )
            .opacity(statistics.percentage == nil ? 0.3 : 1)
        }
    }
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    StatisticsView(statistics: .stat1)
}

#Preview("Light", traits: .sizeThatFitsLayout) {
    StatisticsView(statistics: .stat3)
}
