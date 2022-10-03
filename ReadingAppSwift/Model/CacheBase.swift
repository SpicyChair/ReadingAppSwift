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
    
    init () {
        loadCacheFromFile()
    }
    
    func getBookDetail(key: String) -> BookDetailsModel? {
        if let book = books[key] {
            return book
        } else {
            return nil
        }
    }
        
    func bookInCache(key: String) -> Bool {
        return (books.keys.contains(key))
    }
    
    func addBookToCache(book: BookDetailsModel) {
        if !(books.keys.contains(book.key)) {
            books.updateValue(book, forKey: book.key)
            saveCacheToFile()
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


