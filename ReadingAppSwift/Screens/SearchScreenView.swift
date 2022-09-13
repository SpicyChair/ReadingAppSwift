//
//  SearchScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SearchScreenView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Text("Hello World")
            }.navigationTitle("Search")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
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
