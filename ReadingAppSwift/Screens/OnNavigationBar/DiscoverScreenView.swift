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
    
    @State var loaded = false
    
    @StateObject var state: DiscoverScreenStateController = DiscoverScreenStateController()
    
    
    
    var body: some View {
        NavigationView {
            Form {
                if loaded {
                    ForEach(state.getTags(), id: \.self) { tag in
                        ChipTag(text: tag)
                    }
                }
                
                
            }.navigationTitle("Discover")
                .onAppear(perform: {
                    
                    loaded = false
                    
                    for key in library.library {
                        //access library keys
                        
                        if let book = cache.getBookDetail(key: key) {
                            //then access the env object cache
                            
                            state.text += book.volumeInfo.description
                        }
                        
                    }
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
