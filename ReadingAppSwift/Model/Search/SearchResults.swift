//
//  BookResponse.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct SearchResults : Codable {
    // holds search results in the form of an array of [BookDetailsModel]
    var results: [BookDetailsModel]
    
    private enum CodingKeys:String, CodingKey {
        case results = "items"
    }
}





