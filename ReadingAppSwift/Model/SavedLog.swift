//
//  SavedLog.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 29/11/2022.
//

import Foundation


struct SavedLog : Codable {
    var pageProgress: Int
    var pageCount:Int
    var pagesPerDay: [String : Int]?
}
