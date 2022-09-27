//
//  BookResponse.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct SearchResultBase : Codable {
    var resultCount:Int
    var results: [BookDetailsModel]
    
    private enum CodingKeys:String, CodingKey {
        case resultCount = "totalItems"
        case results = "items"
    }
}



