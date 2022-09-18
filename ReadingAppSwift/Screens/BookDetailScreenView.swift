//
//  BookDetailScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI

struct BookDetailScreenView: View {
    
    @StateObject private var state = BookDetailStateController()
    var key: String
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center) {
                BookCoverImage(key: key, width: 120, height: 180, cornerRadius: 15)
                Text(state.book?.title?.capitalized ?? "Untitled")
                    .bold()
                Text(state.book?.subtitle ?? "No Subtitle")
                    
                
                Section {
                    Text(state.book?.description ?? "No description provided.")
                }
            }.navigationTitle("About Book")
            
        }
        .navigationViewStyle(.stack)
        .task {
            state.key = key
        }
    }
}

struct BookDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailScreenView(key: "string")
    }
}
