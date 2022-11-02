//
//  StatisticsScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 31/10/2022.
//

import SwiftUI

struct StatisticsScreenView: View {
    
    var data: [String : Int] = [
        "01-11-22":1,
        "02-11-22":2,
        "03-11-22":3,
        "04-11-22":4,
        "05-11-22":5,
    ]
    
    var body: some View {
        
Form {
                BarChartView(height: 400, data: data)
            }.navigationTitle("Statistics")
 
    }
}

struct StatisticsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsScreenView(data: [
            "01-11-22":1,
            "02-11-22":2,
            "03-11-22":3,
            "04-11-22":4,
            "05-11-22":5,
        ])
    }
}
