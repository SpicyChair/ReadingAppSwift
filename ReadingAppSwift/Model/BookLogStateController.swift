//
//  BookLogData.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 05/10/2022.
//

import Foundation
import SwiftUI

class BookLogStateController: ObservableObject {
    
    var key = "" {
        // when the key is set by the view, the filename is generated
        // and the data is loaded from the filename
        didSet {
            filename = "\(key)_log.json"
            loadBookLog()
        }
    }
    
    // filename is var as it will change once key changes
    var filename = ""
    
    // allow persistence
    private var fileManager = FileManager()
    
    // total amount of pages
    @Published var pageCount: Int = 1
    
    // total progress in pages
    @Published var pageProgress: Int = 0
    
    // dictionary of dates pointing to number of pages read
    // on that particular day
    @Published var pagesPerDay : [String : Int] = [:]
    
    
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
        saveBookLog()
    }
    
    func setPageProgress(pages: Int) {
        
        // how many pages have actually been read
        // eg. if pages = 40, and the user sets progress to 70
        // 30 pages have been read
        
        let toAdd = abs(pageProgress - pages)
        
        let dateAsString = getDateAsString()
        
        if let currentPages = pagesPerDay[dateAsString] {
            pagesPerDay.updateValue(currentPages + toAdd, forKey: dateAsString)
            
        // else, create a new entry for today
            
        } else {
            pagesPerDay.updateValue(toAdd, forKey: dateAsString)
        }
        
        // update the total progress
        pageProgress = pages
        saveBookLog()
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
    
    // methods for persisting book logs
    
    func loadBookLog() {
        if let loaded: SavedLog = fileManager.loadJSONFromFile(filename: filename) {
            self.pagesPerDay = loaded.pagesPerDay
            self.pageProgress = loaded.pageProgress
            self.pageCount = loaded.pageCount
        }
    }
    
    func saveBookLog() {
        fileManager.saveToJSON(filename: filename , object: SavedLog(pageProgress: self.pageProgress, pageCount: self.pageCount, pagesPerDay: self.pagesPerDay))
    }
    
    func clearBookLog() {
        fileManager.deleteFile(filename: filename)
        self.pageProgress = 0
        self.pagesPerDay = [:]
    }
    
    // struct to facilitate encoding and decoding
    
    struct SavedLog : Codable {
        var pageProgress: Int
        var pageCount:Int
        var pagesPerDay: [String : Int]
    }
    
    
}
