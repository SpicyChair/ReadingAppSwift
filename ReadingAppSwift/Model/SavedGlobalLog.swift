//
//  SavedLog.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 29/11/2022.
//

import Foundation


struct SavedGlobalLog : Codable {
    var pageProgress: Int
    var pageGoal: Int
    var pagesPerDay: [String : Int]?
    var minutesRead: Int
}
