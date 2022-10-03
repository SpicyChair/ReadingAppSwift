//
//  AddToLibraryButton.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 28/09/2022.
//

import SwiftUI

struct AddToLibraryButton: View {
    
    var key: String
    @EnvironmentObject var library: LibraryBase
    
    var body: some View {
        Button(action: addToLibrary) {
            if library.isBookInLibrary(key: self.key) {
                // if the book is in library, show different text
                Label("In Library", systemImage: "checkmark.square")
                    .foregroundColor(Color.green)
            } else {
                Label("Add", systemImage: "plus.square.on.square")
            }
            
        }
        .buttonStyle(.bordered)
    }
    
    func addToLibrary() {
        library.addBookToLibrary(key: self.key)
    }
}

struct AddToLibraryButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToLibraryButton(key: "")
    }
}
