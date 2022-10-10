//
//  HomeScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var cache: CacheBase
    @EnvironmentObject var library: LibraryBase
    @StateObject var logStateController: BookLogStateController = BookLogStateController()
    
    var body: some View {
        NavigationView {
            Form {
                HStack (alignment: .center) {
                    // circle within a circle
                    ZStack {
                        CircleProgressBar(progress: logStateController.globalPageProgress, maxProgress: logStateController.globalPageGoal, color: Color.green, showPercent: false)
                            .frame(width: 100, height: 100)
                        /*
                        CircleProgressBar(progress: 3, maxProgress: 5, color: Color.blue, showPercent: false)
                            .frame(width: 70, height: 70)
                         */
                    }
                    
                    // reading stats
                    
                    VStack (alignment: .leading) {
                        Text("Pages Read")
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            
                        Text("\(logStateController.globalPageProgress) / \(logStateController.globalPageGoal)")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                        Spacer()
                        /*
                        Text("Time Read")
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            
                        Text("10 / 50 min")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                         */
   
                    }
                    .padding()
                }
                    .padding()
                
                Section (header: Text("Saved to Library")) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        // horizontal scrollview
                        HStack (spacing: 12) {
                            ForEach(library.library, id: \.self) { key in
                                //access library keys
                                
                                if let book = cache.getBookDetail(key: key) {
                                    //then access the env object cache
                                    
                                    BookCardVertical(key: book.key,
                                                    title: book.volumeInfo.title,
                                                    authors: book.volumeInfo.authors,
                                                    cover: book.volumeInfo.coverImage)
                                }
                                
                            }
                        }
                    }.padding([.top, .bottom], 10)
                }
                
                Section (header: Text("Persistence Options")) {
                    Button(action: library.clearLibrary) {
                           Label("Clear Library", systemImage: "book.closed")
                    }.foregroundColor(Color.red)
                    
                    Button(action: cache.clearCache) {
                           Label("Clear Cache", systemImage: "xmark")
                    }.foregroundColor(Color.red)
                }
                
            }.navigationTitle("Home")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
