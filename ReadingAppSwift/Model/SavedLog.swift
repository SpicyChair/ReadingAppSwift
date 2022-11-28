//
//  SavedLog.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 28/11/2022.
//

import Foundation

// struct to facilitate encoding and decoding

struct SavedLog : Codable {
    var pageProgress: Int
    var pageCount:Int
    var pagesPerDay: [String : Int]?
}
