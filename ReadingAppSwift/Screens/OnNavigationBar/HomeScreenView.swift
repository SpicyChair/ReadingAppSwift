//
//  HomeScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var cache: CacheBase
    @EnvironmentObject var library: LibraryBase
    
    var body: some View {
        NavigationView {
            Form {
                
                Section (header: Text("Saved to Library")) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        // horizontal scrollview
                        HStack (spacing: 12) {
                            ForEach(library.library, id: \.self) { key in
                                //access library keys
                                
                                if let book = cache.getBookDetail(key: key) {
                                    //then access the env object cache
                                    
                                    BookCardVertical(key: book.key,
                                                    title: book.volumeInfo.title,
                                                    authors: book.volumeInfo.authors,
                                                    cover: book.volumeInfo.coverImage)
                                }
                                
                            }
                        }
                    }.padding([.top, .bottom], 10)
                }
                
                Section (header: Text("Persistence Options")) {
                    Button(action: library.clearLibrary) {
                           Label("Clear Library", systemImage: "book.closed")
                    }.foregroundColor(Color.red)
                    
                    Button(action: cache.clearCache) {
                           Label("Clear Cache", systemImage: "xmark")
                    }.foregroundColor(Color.red)
                }
                
            }.navigationTitle("Home")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}