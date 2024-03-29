//
//  BookDetailsInternalModel.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation

struct BookDetailsModel: Codable, Hashable {
    
    var volumeInfo: BookVolumeInfo
    var saleInfo: BookSaleInfo
    var key: String
    var link: String
    
    
    private enum CodingKeys:String, CodingKey {
        case volumeInfo = "volumeInfo"
        case saleInfo = "saleInfo"
        case key = "id"
        case link = "selfLink"
    }
}
