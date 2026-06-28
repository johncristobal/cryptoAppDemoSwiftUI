//
//  ChartView.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 26/06/26.
//

import SwiftUI

struct ChartView: View {
    
    let data: [Double]
    let maxY: Double
    let minY: Double
    let lineColor: Color
    
    let startDate: Date
    let endDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        self.data = coin.sparkLine?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let change = (data.last ?? 0) - (data.first ?? 0)
        lineColor = change > 0 ? Color.theme.greenTheme : Color.theme.red

        endDate = Date(coinGeckoString: coin.lastUpdated)
        startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chart
                .frame(height: 200)
                .background(background)
                .overlay (chartAxis.padding(.horizontal, 4), alignment: .leading)

            chartLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: .ethereumCoin)
}

extension ChartView {
    private var chart: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPos = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let y = maxY - minY
                    let yPos = (1 - CGFloat((data[index] - minY) / y)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: .init(x: xPos, y: yPos))
                    }
                    path.addLine(to: CGPoint(x: xPos, y: yPos))
                    
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var background: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartAxis: some View {
        VStack(alignment: .leading) {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            let price = ((maxY + minY) / 2).formattedWithAbbreviations()
            Text(price)
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartLabels: some View {
        HStack {
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}
