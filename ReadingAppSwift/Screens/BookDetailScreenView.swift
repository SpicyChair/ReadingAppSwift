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

                Form {
                    let coverImage = BookCoverImage(key: key, width: 150, height: 225, cornerRadius: 10)
                    ZStack {
                            HStack(alignment: .center) {
                                coverImage
                                Text(state.book?.description ?? "No description provided.")
                            }
                    }
                    if let subtitle = state.book?.subtitle?.capitalized {
                        Section {
                            Text(subtitle)
                        }
                    }
                    Section {
                        Text(state.book?.description ?? "No description provided.")
                    }
                }
            .navigationTitle("About Book")
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

