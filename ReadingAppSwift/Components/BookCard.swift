//
//  BookCard.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 14/09/2022.
//

import SwiftUI

struct BookCard: View {
    
    var title: String
    var authors: [String]
    var key: String
    var cover: String
    // when the add to library button pressed
    
    
    var body: some View {
        NavigationLink(destination: BookDetailScreenView(key: key)) {
            HStack (alignment: .center) {
                BookCoverImage(coverImage: cover, width: 80, height: 120, cornerRadius: 12)
            
                VStack (alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .bold()
                        .truncationMode(.tail)
                    Text(authors.first ?? "" )
                    AddToLibraryButton(key: key)
                }
                .padding(20)
            }
            .frame(height: 140)
        }
    }
}

struct BookCard_Previews: PreviewProvider {
    static var previews: some View {
        BookCard(title: "String", authors: ["String"], key: "m1A-DAAAQBAJ", cover: "https://books.google.com/books/content?id=m1A-DAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api")
        
    }
}
