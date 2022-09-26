//
//  BookDetailStateController.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import Foundation

class BookDetailStateController: ObservableObject  {
    
    @Published var book: BookDetails?
    private let adapter = GoogleBooksAdapter()
    
    var key = "" {
        // when this value changes
        didSet {
            // ask the adapter to get the response from the API
            adapter.getBookDetails(key: key, completion: updateBook)
        }
    }
    
    let openLibraryAdapter = GoogleBooksAdapter()
    
    func updateBook(book: BookDetails?) {
        let response = book
        DispatchQueue.main.async{
            self.book = response
        }
    }
}

