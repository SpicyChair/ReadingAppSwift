//
//  DiscoverScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct DiscoverScreenView: View {
    
    @EnvironmentObject var cache: CacheBase
    @EnvironmentObject var library: LibraryBase
    @StateObject var state: DiscoverScreenStateController = DiscoverScreenStateController()
    
    
    @State var loaded: Bool = false

    var body: some View {
        NavigationView {
            Form {
                if loaded && !(library.library.isEmpty) {
                    // create new chiptag per each tag
                    ForEach(state.getTags(), id: \.self) { tag in
                        ChipTag(text: tag)
                    }
                } else {
                    Text("Add books to your library to start getting recommendations")
                }
                
            }.navigationTitle("Discover")
            
            // go through each book in the library and append it to the full text
                .onAppear(perform: {
                    
                    for key in library.library {
                        //access library keys
                        
                        if let book = cache.getBookDetail(key: key) {
                            //then access the env object cache
                            
                            state.text += book.volumeInfo.description
                        }
                        
                    }
                    
                    // set loaded to true - then recommendation system can be used
                    
                    loaded = true
                })
        }
        .navigationViewStyle(.stack)
    }
}

struct DiscoverScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverScreenView()
    }
}

// @State var loaded = false
// loaded = true
