//
//  BookResponse.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct SearchResults : Codable {
    var results: [BookDetailsModel]
    
    private enum CodingKeys:String, CodingKey {
        case results = "items"
    }
}





