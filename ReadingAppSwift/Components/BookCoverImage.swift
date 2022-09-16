//
//  BookCoverImage.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI

struct BookCoverImage: View {
    var key: String
    var width: Float
    var height: Float
    var cornerRadius: Float
    
    var body: some View {
        // ZStack for Book Cover
        ZStack (alignment: .center) {
            
            //ZStack for Placeholder
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(.gray)
                Image(systemName: "xmark.octagon")
            }
            
            // Book Cover
            AsyncImage(url: URL(string: "https://covers.openlibrary.org/w/olid/\(key.split(separator: "/")[1])-M.jpg")) { image in
                image.resizable()
            } placeholder: {
                //placeholder if the image fails to load
                Image(systemName: "xmark.octagon")
            }
        }
        .frame(width: CGFloat(width), height: CGFloat(height))
        .cornerRadius(CGFloat(cornerRadius))
    }
}

struct BookCoverImage_Previews: PreviewProvider {
    static var previews: some View {
        BookCoverImage(key: "String", width: 1, height: 1, cornerRadius: 1)
    }
}
