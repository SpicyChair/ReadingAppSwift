//
//  LibraryBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 03/10/2022.
//

import Foundation

class LibraryBase: ObservableObject {
    
    init () {
        loadFromFile()
    }
    
    
    // array of book keys that the user has saved
    // use these keys to access books
    @Published var library: [String] = []
    let fileManager: FileManager = FileManager()
    let filename = "library.json"

    // methods to interact with the library

    func addBookToLibrary(key: String) {
        if !(library.contains(key)) {
            library.append(key)
        }
    }

    func isBookInLibrary(key: String) -> Bool {
        return library.contains(key)
    }
    
    func saveToFile() {
        fileManager.saveToJSON(filename: filename , object: library)
    }
    
    func loadFromFile() {
        if let loaded: [String] = fileManager.loadJSONFromFile(filename: filename) {
            library = loaded
        }
    }
}
