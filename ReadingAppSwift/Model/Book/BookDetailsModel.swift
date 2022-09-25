//
//  BookDetailsInternalModel.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation

struct BookDetailsModel {
    // internal class so unwrapping of optionals not neccessary thoughout app
    
    var title: String
    var subtitle: String
    var tags: String
    var places: [String]
    var description: String
    
    private struct RawBookDetailsModel: Codable {
        
    }


}
