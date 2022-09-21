//
//  Book.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct SearchResult: Codable, Hashable {
    var key: String
    var type: String
    
    private enum CodingKeys:String, CodingKey {
        case key = "key"
        case type = "type"
    }
}

