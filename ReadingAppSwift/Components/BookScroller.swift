//
//  BookScroller.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 11/11/2022.
//

import SwiftUI

struct BookScroller: View {
    
    @StateObject private var state = SearchStateController()
    @EnvironmentObject var cache: CacheBase
    var searchFor: String
    var excludingKey: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            // horizontal scrollview
            HStack (spacing: 12) {
                
                
                
                if (!state.results.isEmpty) {
                    
                    
                    ForEach(state.results, id: \.self) { book in
                        
        
                        if !(book.key == excludingKey) {
                            // ensure the same book is not recommended twice
                            BookCardVertical(key: book.key,
                                            title: book.volumeInfo.title,
                                            authors: book.volumeInfo.authors,
                                            cover: book.volumeInfo.coverImage,
                                             navToDetails: true)
                                .onAppear {
                                    cache.addBookToCache(toAdd: book)
                                }
                        }
                    }
                }
                
            }
        }
        .padding([.top, .bottom], 10)
        .onAppear(perform: {
            if state.results.isEmpty {
                state.searchFor = self.searchFor
            }
        })
    }
}

struct BookScroller_Previews: PreviewProvider {
    static var previews: some View {
        BookScroller(searchFor: "", excludingKey: "")
    }
}
