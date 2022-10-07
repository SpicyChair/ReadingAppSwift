//
//  BookDetailBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation



class CacheBase : ObservableObject {
    
    // cached books from search
    @Published var books: [String: BookDetailsModel] = [:]
    let filename = "cache.json"
    let fileManager: FileManager = FileManager()
    let adapter = GoogleBooksAdapter()
    
    init () {
        loadCacheFromFile()
    }
    
    func getBookDetail(key: String) -> BookDetailsModel?  {
        if let book = books[key] {
            return book
        } else {
            // if the book is not in the cache, fetch data from API
            adapter.getBookDetails(key: key, completion: addBookToCache)
        }
        return nil
    }
        
    func bookInCache(key: String) -> Bool {
        return books[key] != nil
    }
    
    func addBookToCache(toAdd: BookDetailsModel?) -> Void {
        
        if let book = toAdd {
            if !(books.keys.contains(book.key)) {
                // run on the main thread to stop swiftui complaining
                Task { @MainActor in
                    books.updateValue(book, forKey: book.key)
                    }
                
                saveCacheToFile()
            }
        }
    }
    
    func saveCacheToFile() {
        fileManager.saveToJSON(filename: filename , object: books)
    }
    
    func loadCacheFromFile() {
        if let loaded: [String: BookDetailsModel] = fileManager.loadJSONFromFile(filename: filename) {
            books = loaded
        }
    }
    
    func clearCache() {
        // empty the book dict
        // and delete the json from file
        books = [:]
        fileManager.deleteFile(filename: filename)
    }
}


