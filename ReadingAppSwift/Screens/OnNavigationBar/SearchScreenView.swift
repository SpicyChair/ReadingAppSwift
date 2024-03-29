//
//  SearchScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SearchScreenView: View {
    @State var searchText = ""
    @StateObject private var state = SearchStateController()
    @EnvironmentObject var cache: CacheBase
    @EnvironmentObject var library: LibraryBase
    

    
    var body: some View {
        NavigationView {
            Form {
                TextField (
                    "Search for books",
                    text: $searchText
                )
                .onSubmit {
                    search()
                    
                }
                .onAppear{
                    search()
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                Section(header: Text("Results")) {
                    
                    if (state.results.isEmpty) {
                        Text("Search above!")
                    } else {
                        List {
                            ForEach(state.results, id: \.self) { book in
                                
                                BookCard (
                                    title: book.volumeInfo.title,
                                    authors: book.volumeInfo.authors,
                                    key: book.key,
                                    cover: book.volumeInfo.coverImage
                                )
                                .onAppear {
                                    cache.addBookToCache(toAdd: book)
                                }
                            }
                            
                        }
                    }
    
                    
                }
            }.navigationTitle("Search")
        }
        .navigationViewStyle(.stack)
        
    }
    
    func search() {
        if (!searchText.isEmpty) {
            state.searchFor = searchText
        }
    }
}


struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
    }
}

