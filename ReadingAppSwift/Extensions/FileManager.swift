//
//  FileManager.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 02/10/2022.
//

import Foundation

extension FileManager {
    
    func getDocDirectoryURLWithFilename(filename: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let userPath = paths[0]
        return userPath.appendingPathComponent(filename)
    }
    
    func saveToJSON<T: Codable>(filename: String, object: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            if let json = String(data: encoded, encoding: .utf8) {
                //take encoded objects and convert them into string
                
                let url = getDocDirectoryURLWithFilename(filename: filename)
                do {
                    //write json to file
                    try json.write(to: url, atomically: true, encoding: .utf8)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Unable to form JSON string")
            }
            
        }
    }
    
    func loadJSONFromFile<T: Codable>(filename: String) -> T? {
        let url = getDocDirectoryURLWithFilename(filename: filename)
        
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode(T.self, from: data) {
                return loaded
            }
        }
        print("Could not load from file \(filename)")
        return nil
        
    }
    
    func deleteFile(filename: String) {
        let url = getDocDirectoryURLWithFilename(filename: filename)
        do {
            try self.removeItem(at: url)
        } catch {
            print("Could not delete file \(filename)")
        }
    }
}
