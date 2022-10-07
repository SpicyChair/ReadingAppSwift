//
//  AddToLibraryButton.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 28/09/2022.
//

import SwiftUI

struct AddToLibraryButton: View {
    
    var key: String
    var pagesInBook: Int
    @EnvironmentObject var library: LibraryBase
    
    var body: some View {
        if library.isBookInLibrary(key: self.key) {
            // if the book is in library, show different button(s)
            HStack {
                Button(action: addToLibrary) {
                    // add book to library button
                    
                    Label("Added", systemImage: "checkmark.square")
                        .frame(maxHeight: .infinity)
                        .foregroundColor(Color.green)
                    
                }
                .buttonStyle(.bordered)
                
                Button(action: removeFromLibrary) {
                    //smaller button to remove book from library
                    
                    Image(systemName: "xmark")
                        .frame(maxHeight: .infinity)
                        .foregroundColor(Color.red)
                        
                }
                .buttonStyle(.bordered)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: 200)
            
        } else {
            Button(action: addToLibrary) {
                Label("Add", systemImage: "plus.square.on.square")
            }
            .buttonStyle(.bordered)
        }
        
    }
    
    func addToLibrary() {
        library.addBookToLibrary(key: self.key, pages: pagesInBook)
    }
    
    func removeFromLibrary() {
        library.removeBookFromLibrary(key: self.key)
    }
}

struct AddToLibraryButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToLibraryButton(key: "", pagesInBook: 10)
    }
}
