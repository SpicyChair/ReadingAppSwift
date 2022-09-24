//
//  BookDetailBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation

class BookDetailBase : ObservableObject {
    
    
    @Published var books: [String: BookDetailsInternal] = [:]
    private let placeholder: BookDetailsInternal = BookDetailsInternal(title: "", subtitle: "", tags: "", places: [""], description: "")
    
    func getBookDetail(key: String) -> BookDetailsInternal {
        if let book = books[key] {
            return book
        } else {
            return placeholder
        }
    }
}


