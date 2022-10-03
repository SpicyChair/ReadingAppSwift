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
    

    
    func getBookDetail(key: String) -> BookDetailsModel? {
        if let book = books[key] {
            return book
        } else {
            return nil
        }
    }
        
    func bookInBase(key: String) -> Bool {
        return (books.keys.contains(key))
    }
    
    func addBookToBase(book: BookDetailsModel) {
        books.updateValue(book, forKey: book.key)
    }
    
}


