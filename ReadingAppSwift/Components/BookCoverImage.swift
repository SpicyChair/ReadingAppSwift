//
//  BookCoverImage.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI
import Kingfisher

struct BookCoverImage: View {
    var coverImage: String
    var width: Float
    var height: Float
    var cornerRadius: Float
    
    var body: some View {
        
        let url = URL(string: coverImage)
        
        // ZStack for Book Cover
        ZStack (alignment: .center) {
            
            //ZStack for Placeholder
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(.gray)
                Image(systemName: "xmark.octagon")
            }
            // kingfisher used 
            KFImage(url)
                .resizable()
                .cacheOriginalImage()

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
