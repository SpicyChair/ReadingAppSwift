//
//  BookLogBase.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 08/10/2022.
//

import Foundation

class BookLogBase: ObservableObject {
    // book key points to the book log data
    // separate to ensure removing from library does not remove
    // log data
    @Published var log: [String : BookLogData] = [:]
    
    let fileManager: FileManager = FileManager()
    let log_filename = "book_log.json"

    
    // methods for handling logs
    /*
    func saveLogToFile() {
        fileManager.saveToJSON(filename: log_filename, object: log)
    }
    
    func loadLogFromFile() {
        if let loaded: [String: BookLogData] = fileManager.loadJSONFromFile(filename: log_filename) {
            log = loaded
        }
    }
     */
    
    func getBookLog(key: String) -> BookLogData {
        if let bookLog = log[key] {
            return bookLog
        }
        let bookLog = BookLogData()
        log.updateValue(bookLog, forKey: key)
        return bookLog
    }
    
    func logPages(key: String, pages: Int) {
        getBookLog(key: key).logPages(pages: pages)
    }
    
    func clearLog() {
        
        // empty the array
        // and delete the json from file
        
        log = [:]
        fileManager.deleteFile(filename: log_filename)
    }

}
