//
//  BookDetailScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI

struct BookDetailScreenView: View {
    
    var key: String
    @EnvironmentObject var bookDetailsBase:BookBase
    
    var body: some View {

                Form {
                    
                    if let book = bookDetailsBase.getBookDetail(key: key) {
                        
                        HStack {
                            BookCoverImage(coverImage: book.volumeInfo.coverImage, width: 150, height: 225, cornerRadius: 10)
                        }
                        Text(book.volumeInfo.title)
                            .bold()
                        Text(book.volumeInfo.authors.first ?? "")
                        AddToLibraryButton(key: key)
                        Text(book.volumeInfo.description)
                        
                        
                    } else {
                        Text("Could not retrieve book information.")
                    }
                    
                }
            .navigationTitle("About Book")
    }
}

struct BookDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailScreenView(key: "")
    }
}

