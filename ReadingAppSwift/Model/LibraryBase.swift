//
//  LibraryBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 03/10/2022.
//

import Foundation

class LibraryBase: ObservableObject {
    
    init () {
        loadLibraryFromFile()
    }
    
    
    // array of book keys that the user has saved
    // use these keys to access books
    @Published var library: [String] = []
    
    // book key points to the book log data
    // separate to ensure removing from library does not remove
    // log data
    @Published var log: [String : BookLogData]
    
    
    let fileManager: FileManager = FileManager()
    let library_filename = "library.json"
    let log_filename = "book_log.json"

    // methods to interact with the library

    func addBookToLibrary(key: String) {
        if !(library.contains(key)) {
            library.append(key)
            saveLibraryToFile()
        }
    }
    
    func removeBookFromLibrary(key: String) {
        // find the index of the item
        if let index = library.firstIndex(of: key) {
            // remove the item from the array
          library.remove(at: index)
        }
    }

    func isBookInLibrary(key: String) -> Bool {
        return library.contains(key)
    }
    
    func saveLibraryToFile() {
        fileManager.saveToJSON(filename: library_filename , object: library)
    }
    
    func loadLibraryFromFile() {
        if let loaded: [String] = fileManager.loadJSONFromFile(filename: library_filename) {
            library = loaded
        }
    }
    
    func clearLibrary() {
        
        // empty the array
        // and delete the json from file
        
        library = []
        fileManager.deleteFile(filename: library_filename)
    }
}
