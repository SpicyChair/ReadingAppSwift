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
    
    @ObservedObject var log: BookLogData
    var key: String
    
    init (key: String) {
        self.key = key
        self.log = BookLogData()
    }
    
    var body: some View {
        Form {
            if let book = cache.getBookDetail(key: key) {
                VStack (alignment: .center) {
                    HStack {
                        BookCoverImage(coverImage: book.volumeInfo.coverImage, width: 150, height: 225, cornerRadius: 10)
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
                    Text("Page Count: \(log.pageCount)")
                    
                    Stepper(onIncrement: {
                        
                        log.logPages(pages: 1)
                    }, onDecrement: {
                        
                        log.logPages(pages: -1)
                    }) {
                        Text("Progress: \(log.pageProgress)")
                    }
                    
                }
                .onAppear {
                    log.pageCount = book.volumeInfo.pageCount
                    //print(log.pageCount)
                }
                
                Section (header: Text("More Information")) {
                    Text("\(book.volumeInfo.pageCount) pages")
                    Text("Language: \(book.volumeInfo.language)")
                }

            } else {
                Text("Could not retrieve book information.")
            }
            
        }
    .navigationTitle("About Book")
    }
}

struct BookLogScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BookLogScreenView(key: "6DRHCgAAQBAJ")
    }
}
