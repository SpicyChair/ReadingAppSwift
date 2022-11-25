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
    
    // property which is updated when recommendations are generated fully
    @State var loaded: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                // only load UI once recommendations have finished loading
                // and there is a library to recommend from
                
                if loaded && !(library.library.isEmpty) {
                    // create new chiptag per each tag
                    
                    Section {
                        VStack (alignment: .leading) {
                            Text("Because you're a fan of")
                                .font(.system(size: 17, weight: .regular, design: .serif))
                                
                            Text(state.mostFrequentAuthor)
                                .font(.system(size: 20, weight: .bold, design: .serif))
                            
                        }
                        
                        BookScroller(searchFor: state.mostFrequentAuthor, excludingKey: "")
                        
                    }
                    
                    Section {
                        VStack (alignment: .leading) {
                            Text("Because you like")
                                .font(.system(size: 17, weight: .regular, design: .serif))
                                
                            Text(state.mostFrequentGenre)
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                
                            
                        }
                        
                        BookScroller(searchFor: state.mostFrequentGenre, excludingKey: "")
                    }
                    
                    Section {
                        Text("Your most frequent categories")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(state.getDescriptionTags(), id: \.self) { tag in
                                    ChipTag(text: tag)
                                }
                            }
                        }
                    }
                    
                     
                } else {
                    Text("Add books to your library to start getting recommendations")
                }
                
            }.navigationTitle("Discover")
            
            // go through each book in the library and append it to the full text
                .onAppear(perform: {
                    
                    refreshRecommendations()
                    
                    // set loaded to true - then recommendation system can be used
                    
                    loaded = true
                    
                    
                })
        }
        .refreshable {
            refreshRecommendations()
        }
        .navigationViewStyle(.stack)
    }
    
    func refreshRecommendations() {
        state.reset()
        if !(library.library.isEmpty) {
            // get the most frequent author and genre
            
            
            var books : [BookDetailsModel] = []
            
            for key in library.library {
                //access library keys
                
                if let book = cache.getBookDetail(key: key) {
                    //then access the env object cache
                    
                    state.text += book.volumeInfo.description
                    books.append(book)
                }
                
            }
            state.getMostFrequentAuthorAndGenre(library: books)
            
        }
    }
}

struct DiscoverScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverScreenView()
    }
}

// @State var loaded = false
// loaded = true
