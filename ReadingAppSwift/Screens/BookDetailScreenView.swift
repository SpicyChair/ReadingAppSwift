//
//  BookDetailScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import SwiftUI

struct BookDetailScreenView: View {
    var body: some View {
        NavigationView {
            Form {
                Text("About Book")
                
                Section {
                    
                }
            }.navigationTitle("About Book")
            
        }
        .navigationViewStyle(.stack)
    }
}

struct BookDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailScreenView()
    }
}
