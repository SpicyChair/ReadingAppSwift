//
//  GlobalLogBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 10/10/2022.
//

import Foundation


class GlobalLogBase: ObservableObject {
    
    var filename = "global_log_stats.json"
    
    // allow persistence
    private var fileManager = FileManager()
    
    // the page goal
    @Published var pageGoal: Int = 50
    
    // total progress in pages
    @Published var pageProgress: Int = 0
    
    // dictionary of dates pointing to number of pages read
    // on that particular day
    @Published var pagesPerDay : [String : Int] = [:]
    
    init () {
        
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
    
    func loadGlobalBookLog() {
        if let loaded: SavedGlobalLog = fileManager.loadJSONFromFile(filename: filename) {
            self.pagesPerDay = loaded.pagesPerDay
            self.pageProgress = loaded.pageProgress
            self.pageGoal = loaded.pageGoal
        }
    }
    
    func saveGloalBookLog() {
        fileManager.saveToJSON(filename: filename , object: SavedGlobalLog(pageProgress: self.pageProgress, pageGoal: self.pageGoal, pagesPerDay: self.pagesPerDay))
    }
    
    func clearGlobalBookLog() {
        fileManager.deleteFile(filename: filename)
        self.pageProgress = 0
        self.pagesPerDay = [:]
    }
    
    struct SavedGlobalLog : Codable {
        var pageProgress: Int
        var pageGoal:Int
        var pagesPerDay: [String : Int]
    }
}
