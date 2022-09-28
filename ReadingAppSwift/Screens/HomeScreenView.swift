//
//  HomeScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var bookBase: BookBase
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(bookBase.library, id: \.self) { key in
                        //access library keys
                        
                        if let book = bookBase.getBookDetail(key: key) {
                            //then access the env object cache
                            
                            VStack {
                                Text(book.volumeInfo.title)
                                    .bold()
                                Text(book.volumeInfo.authors.first ?? "")
                            }
                        }
                        
                    }
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
