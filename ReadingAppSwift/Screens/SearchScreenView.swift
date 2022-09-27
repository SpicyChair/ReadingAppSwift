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
                    if (!searchText.isEmpty) {
                        state.searchFor = searchText
                    }
                    
                }
                .autocapitalization(.none)
                
                Section {
                    state.results.isEmpty
                        ?
                        Text("Search above!")
                        .bold()
                        :
                        Text("Results for \(searchText)")
                        .bold()
                    List {
                        ForEach(state.results, id: \.self) { result in
                            //TODO: DISPLAY BOOKCARD IF RESULT IS A BOOK, OR ELSE AN AUTHORCARD
                            BookCard (
                                title: "\(result.id)",
                                author: "\(result.kind)",
                                key: result.id

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
 */
