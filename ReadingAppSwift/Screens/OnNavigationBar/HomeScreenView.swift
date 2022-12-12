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
    @EnvironmentObject var bookLogBase: BookLogBase
    @State var minutesToLog: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                HStack (alignment: .center) {
                    // circle within a circle
                    ZStack {
                        CircleProgressBar(progress: bookLogBase.globalPageProgress, maxProgress: bookLogBase.globalPageGoal, color: Color.green, showPercent: false)
                            .frame(width: 100, height: 100)
                        
                        CircleProgressBar(progress: bookLogBase.minutesRead, maxProgress: 50, color: Color.blue, showPercent: false)
                            .frame(width: 70, height: 70)
                         
                    }
                    
                    // reading stats
                    
                    VStack (alignment: .leading) {
                        Text("Pages Read Today")
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            
                        Text("\(bookLogBase.globalPageProgress) / \(bookLogBase.globalPageGoal)")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                        Spacer()
                        
                        Text("Time Read Today")
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            
                        Text("\(bookLogBase.minutesRead) / 50 min")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                        
                        
                        // text field with a set button to change minutes read
                        
                        HStack {
                            TextField("Time Read", text: $minutesToLog)
                                .keyboardType(.numberPad)
                                .frame(maxWidth: Double.infinity)
                            Button("Set") {
                                if let minutes = Int(minutesToLog) {
                                    bookLogBase.minutesRead = minutes
                                    bookLogBase.saveGlobalBookLog()
                                }
                            }.buttonStyle(.bordered)
                            
                        }
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
                    
                    Button(action: bookLogBase.clearGlobalBookLog) {
                           Label("Clear Global Log Data", systemImage: "xmark")
                    }.foregroundColor(Color.red)
                    
                }
                
            }.navigationTitle("Home")
                 
            
            
            
        }
        .navigationViewStyle(.stack)
    }
}

