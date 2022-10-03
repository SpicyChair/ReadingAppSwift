//
//  SearchScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SearchScreenView: View {
    @State private var searchText = ""
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
                    if (!searchText.isEmpty) {
                        state.searchFor = searchText
                    }
                    
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                Section {
                    state.results.isEmpty
                        ?
                        Text("Search above!")
                        .bold()
                        :
                        Text("Results for \(searchText)")
                        .bold()
                    List {
                        ForEach(state.results, id: \.self) { book in
                            
                            BookCard (
                                title: book.volumeInfo.title,
                                authors: book.volumeInfo.authors,
                                key: book.key,
                                cover: book.volumeInfo.coverImage
                            )
                            .onAppear {
                                cache.addBookToBase(book: book)
                            }
                        }
                        
                    }
                }
            }.navigationTitle("Search")
        }
        .navigationViewStyle(.stack)
        
    }
}


struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
    }
}

