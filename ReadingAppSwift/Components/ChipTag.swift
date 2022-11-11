//
//  ChipTag.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 31/10/2022.
//

import SwiftUI

struct ChipTag: View {
    
    var text: String
    
    var body: some View {
        NavigationLink (destination: SearchScreenView(searchText: text)){
            Text(text)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                       .strokeBorder()
                        .foregroundColor(.gray)
                    )
        }
        
            
    }
}

