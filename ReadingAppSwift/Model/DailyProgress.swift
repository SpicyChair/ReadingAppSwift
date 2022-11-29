//
//  DailyLogData.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 01/11/2022.
//

import Foundation


class DailyProgress: Codable {
    
    var key: String
    var data: [String: ProgressData]
    
    
    func logProgress(progress: Int) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let dateAsString = dateFormatter.string(from: date)
        
        if (data[dateAsString] == nil) {
            // create new k:v if not existing
            data[dateAsString] = ProgressData(date: dateAsString, progress: 0)
        }
        
        // increase the progress
        data[dateAsString]?.progress += progress
        
    }
    
    
    
    
}

struct ProgressData: Codable {
    
    var date: String
    var progress: Int

}
