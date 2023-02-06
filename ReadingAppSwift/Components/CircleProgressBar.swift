//
//  CircleProgressBar.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 09/10/2022.
//

import SwiftUI

struct CircleProgressBar: View {
    
    //current progress
    var progress: Int
    
    //maximum possible progress
    var maxProgress: Int
    
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
            // get part of circle
            // this shows progress
                .trim(from: 0, to: (Double(progress) / Double(maxProgress)))
                .stroke(
                    color,
                    style: StrokeStyle (
                        lineWidth: 15,
                        lineCap: .round
                    )
    
                )
            // rotate -90 degrees to start from the top
                .rotationEffect(.degrees(-90))
            // animate changes
                .animation(.easeOut, value: progress)
            
            // if showPercent show a nicely formatted percent value in the centre
            if showPercent {
                Text("\(((Double(progress) / Double(maxProgress)) * 100), specifier: "%.1f")%")
                    .font(.system(size: 22, weight: .bold, design: .serif))
            }
        }
    }
}

