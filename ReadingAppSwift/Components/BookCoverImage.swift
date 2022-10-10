//
//  BookCoverImage.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI

struct BookCoverImage: View {
    var coverImage: String
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
            
            // https://i.guim.co.uk/img/media/35426ac29e959093643705eb149e9779c23a30d8/0_262_3500_2100/master/3500.jpg?width=620&quality=85&dpr=1&s=none
            AsyncImage(url: URL(string: coverImage)) { image in
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
        BookCoverImage(coverImage: "", width: 120, height: 180, cornerRadius: 15)
    }
}
