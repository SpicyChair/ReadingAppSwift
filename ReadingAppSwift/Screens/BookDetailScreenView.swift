//
//  BookDetailScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI

struct BookDetailScreenView: View {
    
    var key: String
    @EnvironmentObject var cache:CacheBase
    
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
                            
                            AddToLibraryButton(key: key)
                        //padding to top and bottom of the vstack
                        }.padding([.top, .bottom], 10)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(book.volumeInfo.categories, id: \.self) { category in
                                    ChipTag(text: category, color: Color.gray)
                                }
                            }
                        }
                        
                        Section (header: Text("Description")) {
                            Text(book.volumeInfo.description)
                        }
                        
                        Section (header: Text("More Information")) {
                            Text("Published \(book.volumeInfo.publishedDate)")
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

struct BookDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailScreenView(key: "")
    }
}

