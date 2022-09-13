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
                Section {
                    searchText.isEmpty
                    ?
                    Text("Search above!")
                    :
                    Text("Searching for \(searchText)")
                }
                Section {
                    List {
                        Text("Hi")
                        Text("Hi")
                        Text("Hi")
                        Text("Hi")
                    }
                }
            }.navigationTitle("Search")
            
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),  prompt: "Search for books and authors")
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
