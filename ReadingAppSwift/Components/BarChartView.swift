//
//  BarChartView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 31/10/2022.
//

import SwiftUI

struct BarChartView: View {
    
    var height: Double
    var data: [String : Int]
    var largestValue: Int
    var color: Color = .green
    
    init(height: Double, data: [String: Int]) {
        self.height = height
        self.data = data
        self.largestValue = data.values.max() ?? 0
        
    }
    
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                
                ForEach(data.sorted(by: <), id: \.key) { key, value in
                    let barHeight: Double = (Double(value) / Double(largestValue) * (height * 0.8))
                    let barWidth: Double = 10
                    Spacer()
                    VStack (alignment: .center) {
                        Text(key)
                            .rotationEffect(Angle(degrees: 180))
                        RoundedRectangle(cornerRadius: 25)
                            .size(width: barWidth, height: barHeight)
                            .fill(.green)

                    }.rotationEffect(Angle(degrees: 180))

                }
                
                
            }
        }.frame(height: height)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(height: 100, data: ["":0])
    }
}
