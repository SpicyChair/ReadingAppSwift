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
    
            HStack (alignment: .center) {
                
                BookCoverImage(key: key, width: 80, height: 120, cornerRadius: 12)
            
                VStack (alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .bold()
                        .truncationMode(.tail)
                    Text(author)
                    Button("Add to Library", action: addToLibrary)
                        .buttonStyle(.bordered)
                }
                .padding(20)
                
                
            }
            .frame(height: 140)
            .onTapGesture {
                //TODO: ONTAP GESTURE FOR BOOKCARD
            }
    }
    
    func addToLibrary() {
        //TODO: ADD TO LIBRARY FUNCTIONALITY
        return
    }
}

struct BookCard_Previews: PreviewProvider {
    static var previews: some View {
        BookCard(title: "String", author: "String", key: "String")
    }
}
