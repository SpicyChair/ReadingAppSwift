//
//  BookResponse.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct SearchResponse : Codable {
    var resultCount:Int
    var results: [Book]
    
    private enum CodingKeys:String, CodingKey {
        case resultCount = "numFound"
        case results = "docs"
    }
}


