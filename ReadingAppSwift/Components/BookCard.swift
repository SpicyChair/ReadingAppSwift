//
//  BookCard.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 14/09/2022.
//

import SwiftUI

struct BookCard: View {
    
    var title: String
    var author: String
    var key: String
    
    
    var body: some View {
        ZStack (alignment: .leading) {
                
            HStack (alignment: .center) {
                RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .frame(width:80, height: 120)
                
                VStack (alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .bold()
                        .truncationMode(.tail)
                    Text(author)
                }
                .padding(20)
                        //.multilineTextAlignment(.leading)
            }
            .frame(height: 140)
        }
        .onTapGesture {
            print("BookCard Tapped")
        }
    }
}

struct BookCard_Previews: PreviewProvider {
    static var previews: some View {
        BookCard(title: "String", author: "String", key: "String")
    }
}
