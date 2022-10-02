//
//  BookCard.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 28/09/2022.
//

import SwiftUI

struct BookCardVertical: View {
    
    var key: String
    var title: String
    var authors: [String]
    var cover: String
    
    var body: some View {
        NavigationLink(destination: BookDetailScreenView(key: key)) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.secondarySystemBackground))
                VStack (alignment: .center) {
                    BookCoverImage(coverImage: cover, width: 110, height: 165, cornerRadius: 12)

                    VStack (alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .bold()
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                        Text(authors.first ?? "" )
                    }
                    
                }
                .frame(width: 110, height: 235)
            }
            .frame(width: 135, height: 260)
        }
    }
}

struct BookCardCompact_Previews: PreviewProvider {
    static var previews: some View {
        BookCardVertical(key: "", title: "", authors: [], cover: "")
    }
}
