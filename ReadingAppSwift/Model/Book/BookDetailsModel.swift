//
//  BookDetailsInternalModel.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation

struct BookDetailsModel {
    // internal class so unwrapping of optionals not neccessary thoughout app
    
    var title, subtitle: String
    var author: String
    var date_published: String
    
    private struct RawBookDetailsModel: Codable {
        let title: String?
        let subtitle: String?
        
    }


}
