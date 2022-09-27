//
//  BookDetailsInternalModel.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 21/09/2022.
//

import Foundation

struct BookDetailsModel: Codable {
    var volumeInfo: BookVolumeInfo
    var saleInfo: BookSaleInfo
    
    
    private enum CodingKeys:String, CodingKey {
        case volumeInfo = "volumeInfo"
        case saleInfo = "saleInfo"
    }
}
