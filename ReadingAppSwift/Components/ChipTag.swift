//
//  ChipTag.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 31/10/2022.
//

import SwiftUI

struct ChipTag: View {
    
    //current progress
    var text: String
    
    var color: Color
    
    var body: some View {
        Text(text)
            .padding(8)
            .overlay(
                           RoundedRectangle(cornerRadius: 20)
                               .strokeBorder()
                               .foregroundColor(.gray)
                       )
    }
}

