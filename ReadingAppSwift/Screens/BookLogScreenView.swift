//
//  BookLogScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 05/10/2022.
//

import SwiftUI

struct BookLogScreenView: View {
    
    @EnvironmentObject var cache: CacheBase
    @EnvironmentObject var library: LibraryBase
    @EnvironmentObject private var state: BookLogBase
    
    @State private var pageProgressToLog: String = ""
    
    let key: String
    
    
    var body: some View {
        
        Form {
            if let book = cache.getBookDetail(key: key) {
                    VStack (alignment: .center) {
                        HStack (alignment: .center) {
                            BookCoverImage(coverImage: book.volumeInfo.coverImage, width: 120, height: 180, cornerRadius: 10)
                                .padding([.trailing], 10)
                            
                            VStack (alignment: .leading) {
                                // book title in large text
                                Text(book.volumeInfo.title)
                                    .font(.system(size: 25, weight: .bold, design: .serif))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxHeight: 300)
                                
                                //book author in smaller text
                                Text(book.volumeInfo.authors.first ?? "")
                                    .font(.system(size: 20, design: .serif))
                            }
                        }
                        
                        //AddToLibraryButton(key: key)
                    //padding to top and bottom of the vstack
                    }.padding([.top, .bottom], 10)
                    
                    Section (header: Text("Log Data")) {
                        HStack (alignment: .center) {
                            
                            // circular progress bar
                            // cast variables to double
                            
                            CircleProgressBar(progress: state.pageProgress, maxProgress: state.pageProgress, color: Color.green, showPercent: true)
                                .frame(width: 100, height: 100)
                            
                            Spacer()
                            
                            // show details
                            VStack (alignment: .leading) {
                                Text("Progress")
                                    .font(.system(size: 20, weight: .regular, design: .serif))
                                    
                                Text("\(state.getPageProgress(key: key)) / \(state.getPageCount(key: key))")
                                    .font(.system(size: 30, weight: .bold, design: .serif))
                                Stepper(onIncrement: {
                                    state.logPages(pages: 1)
                                }, onDecrement: {
                                    state.logPages(pages: -1)
                                }) {
                                    
                                }.frame(width: 85)
                            }
                            .padding()
                        }
                            .padding()
                        
                        
                        
                        HStack {
                            TextField("Set Progress", text: $pageProgressToLog)
                                .keyboardType(.numberPad)
                                .frame(maxWidth: Double.infinity)
                            Button("Set") {
                                if let number = Int(pageProgressToLog) {
                                    // if number in range 0 to state.pageCount
                                    if (0...state.getPageCount(key: key) ~= number) {
                                        state.setPagesNew(pages: number, key: key)
                                    }
                                }
                            }.buttonStyle(.bordered)
                            
                        }.onAppear {
                            state.checkLogForKey(key: key)
                        }
                        /*
                        NavigationLink {
                            StatisticsScreenView()//data: state.pagesPerDay)
                        } label: {
                            Label("Statistics", systemImage: "info.circle")
                        }
                         */
                        
                        
                        
                        
                    }
                
                NavigationLink {
                    BookDetailScreenView(key: key)
                } label: {
                    Label("More Book Details", systemImage: "info.circle")
                }
                
                
                
                
                Section (header: Text("Persistence Options")) {
                    Button(action:{
                        state.clearBookLogNew(key: key)
                        
                    }) {
                        // clear logged data without removing any data from the book log
                           Label("Clear Logged Pages", systemImage: "xmark")
                    }.foregroundColor(Color.red)
                    
                    Button(action: {
                        // remove the book from the library
                        // this will keep any logged data
                        library.removeBookFromLibrary(key: key)
                    }) {
                           Label("Remove From Library", systemImage: "xmark")
                    }.foregroundColor(Color.red)
                    
                }

            } else {
                Text("Could not retrieve book information.")
            }
            
        }
    .navigationTitle("About Book")
    }
    
    struct IncrementButton: View {
            var incrementBy: Int
            var text: String
            
            var body: some View {
                Button(action: {
                    //state.logPages(pages: incrementBy)
                    }, label : {
                        Text(text)
                            .frame(maxWidth: .infinity)    // << !!
                    }).buttonStyle(.bordered)
            }
        }
    
    
}

struct BookLogScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BookLogScreenView(key: "6DRHCgAAQBAJ")
    }
}
