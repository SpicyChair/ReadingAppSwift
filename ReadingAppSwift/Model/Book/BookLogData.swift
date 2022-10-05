//
//  BookLogData.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 05/10/2022.
//

import Foundation


class BookLogData: Codable {
    
    // total amount of pages
    let pageCount: Int
    
    // total progress in pages
    var pageProgress: Int = 0
    
    // dictionary of dates pointing to number of pages read
    // on that particular day
    var pagesPerDay : [String : Int]
    
    func logPages(pages: Int) {
        
        // the amount of pages to add
        var toAdd = 0
        
        // pages read can never be greater than the amount of pages in the book
        if (pageProgress + pages >= pageCount) {
            toAdd = pageCount - pageProgress
        } else {
            toAdd = pages
        }
        
        // calculate dateAsString
        // this is used as the key in the pagesPerDay dictionary
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let dateAsString = "\(day)-\(month)-\(year)"

        // if an entry exists for today, add the new pages
        
        if let currentPages = pagesPerDay[dateAsString] {
            pagesPerDay.updateValue(currentPages + toAdd, forKey: dateAsString)
            
        
        // else, create a new entry for today
            
        } else {
            pagesPerDay.updateValue(currentPages + toAdd, forKey: dateAsString)
        }
        
        // update the total progress
        pageProgress += toAdd
    }
}
