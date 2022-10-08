//
//  BookLogData.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 08/10/2022.
//

import Foundation

class BookLogData: ObservableObject {
    // total amount of pages
    @Published var pageCount: Int = 0
    
    // total progress in pages
    @Published var pageProgress: Int = 0
    
    // dictionary of dates pointing to number of pages read
    // on that particular day
    @Published var pagesPerDay : [String : Int] = [:]
}
