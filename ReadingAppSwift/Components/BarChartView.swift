//
//  BarChartView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 31/10/2022.
//

import SwiftUI

struct BarChartView: View {
    
    var height: Int
    var data: [String : Int]
    var largestValue: Int
    
    init(height: Int, data: [String: Int]) {
        self.height = height
        self.data = data
        
        self.largestValue = data.values.max() ?? 0
        
    }
    
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                
            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(height: 100, data: ["":0])
    }
}
