//
//  BookDetails.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/09/2022.
//

import Foundation

struct BookDetails: Codable, Hashable {
    
    var title: String?
    var subtitle: String?
    var tags: [String]?
    var places: [String]?
    var description: String?

    private enum CodingKeys:String, CodingKey {
           case title = "title"
           case subtitle = "subtitle"
           case tags = "subjects"
           case places = "subject_places"
           case description = "description"
    }
}
