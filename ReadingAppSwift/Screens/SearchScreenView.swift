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
                
                
                state.books.isEmpty
                    ?
                    Text("Search above!")
                    .bold()
                    :
                    Text("Results for \(searchText)")
                    .bold()
                
                Section {
                    List {
                        ForEach(state.books, id: \.self) { book in
                            Text("\(book.title), \(book.authors.first ?? "No author")")
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
