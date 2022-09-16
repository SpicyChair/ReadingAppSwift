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
    
    var body: some View {
        NavigationView {
            Form {
                TextField (
                    "Search for books",
                    text: $searchText
                )
                .onSubmit {
                    state.searchFor = searchText
                }
                .autocapitalization(.none)
                
                Section {
                    state.books.isEmpty
                        ?
                        Text("Search above!")
                        .bold()
                        :
                        Text("Results for \(searchText)")
                        .bold()
                    List {
                        ForEach(state.books, id: \.self) { book in
                            BookCard (
                                title: "\(book.title.capitalized)",
                                author: { () -> String in
                                    
                                    if let authors = book.authors {
                                        return authors.first?.capitalized ?? "No author"
                                    }
                                    return "No author"
                                }(),
                                key: book.key
                                
                            )
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

/*
 Text("Search")
     .font(.largeTitle)
     .bold()
 UISearchBar()
 */
