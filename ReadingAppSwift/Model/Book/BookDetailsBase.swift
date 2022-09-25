//
//  BookDetailBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation

class BookDetailsBase : ObservableObject {
    
    
    @Published var books: [String: BookDetailsModel] = [:]
    private let placeholder: BookDetailsModel = BookDetailsModel(title: "", subtitle: "", tags: "", description: "")
    
    func getBookDetail(key: String) -> BookDetailsModel {
        if let book = books[key] {
            return book
        } else {
            return placeholder
        }
    }
}


