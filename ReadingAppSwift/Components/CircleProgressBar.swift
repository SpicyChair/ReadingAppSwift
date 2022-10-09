//
//  CircleProgressBar.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 09/10/2022.
//

import SwiftUI

struct CircleProgressBar: View {
    
    //current progress
    var progress: Double
    
    //maximum possible progress
    var maxProgress: Double
    
    var color: Color
    
    var showPercent: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: 15
                )
            Circle()
                .trim(from: 0, to: (progress / maxProgress)) // 1
                .stroke(
                    color,
                    style: StrokeStyle (
                        lineWidth: 15,
                        lineCap: .round
                    )
    
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            if showPercent {
                Text("\(((progress / maxProgress) * 100), specifier: "%.1f")%")
                    .font(.system(size: 22, weight: .bold, design: .serif))
            }
            
            
        }
    }
}

