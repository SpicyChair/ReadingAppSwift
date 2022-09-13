//
//  Book.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct Book: Codable, Hashable {
    var title: String
    var key: String
    //var authors: [String]
    
    private enum CodingKeys:String, CodingKey {
           case title = "title"
           case key = "key"
           //case authors = "author_name"
    }
}

