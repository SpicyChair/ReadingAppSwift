//
//  StatisticsScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 31/10/2022.
//

import SwiftUI

struct StatisticsScreenView: View {
    var body: some View {
        NavigationView {
            Form {
                BarChartView(height: 400, data: [
                    "1":1,
                    "2":2,
                    "3":3,
                    "4":4,
                    "5":5,
                ])
            }.navigationTitle("Statistics")
        }
        .navigationViewStyle(.stack)
    }
}

struct StatisticsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsScreenView()
    }
}
