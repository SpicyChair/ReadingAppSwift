//
//  Book.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

struct SearchResult: Codable, Hashable {
    var id: String
    var kind: String
    
    
    private enum CodingKeys:String, CodingKey {
        case id = "id"
        case kind = "kind"
    }
}

