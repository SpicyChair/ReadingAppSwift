//
//  BookLogData.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 05/10/2022.
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
    
    init() {}
    
    func logPages(pages: Int) {
        
        // the amount of pages to add
        var toAdd = 0
        
        // pages read can never be greater than the amount of pages in the book
        if (pageProgress + pages >= pageCount) {
            toAdd = pageCount - pageProgress
            
            
        // pages read can never be negative!
        } else if (pageProgress + pages < 0){
            toAdd = pageProgress * (-1)
        } else {
            toAdd = pages
        }
        // if an entry exists for today, add the new pages
        
        let dateAsString = getDateAsString()
        
        if let currentPages = pagesPerDay[dateAsString] {
            pagesPerDay.updateValue(currentPages + toAdd, forKey: dateAsString)
            
        // else, create a new entry for today
            
        } else {
            pagesPerDay.updateValue(toAdd, forKey: dateAsString)
        }
        
        // update the total progress
        pageProgress += toAdd
    }
    
    func getDateAsString() -> String {
        
        // calculate dateAsString
        // this is used as the key in the pagesPerDay dictionary
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return "\(day)-\(month)-\(year)"
    }
}
