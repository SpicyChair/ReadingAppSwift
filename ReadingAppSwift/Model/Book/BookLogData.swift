//
//  BookLogData.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 05/10/2022.
//

import Foundation


class BookLogData: Codable {
    
    let pageCount: Int
    var pageProgress: Int
    var pagesPerDay : [String : Int]
    
    func logPages(pages: Int) {
        if (pageProgress + pages >= pageCount) {
            let toAdd = pageCount - pageProgress
            
            
        } else {
            pageProgress += pages
        }
    }
    
    
}
