//
//  OpenLibraryAdapter.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

class GoogleBooksAdapter {
    

    
    
    // the base url for the google books api
    let baseUrl = "https://www.googleapis.com/books/v1"
    let responseLimit = 10
    
    func getSearchResponse(search: String, completion: @escaping ([BookDetailsModel]?) -> Void ) {
        // the completion parameter is a function
        // it dictates what to do on completion of the response
        // in this case, this means updating data if successful
        // and passing in nil means faliure
        
        // creates a path; addPercentEncoding allows for spaces in the search string
        // limit the fields to key, title, and author_name, and limit the number of responses
        let path = "/volumes?q=\(search)&projection=full&maxResults=\(responseLimit)&fields=items&key=\(booksApiKey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // the guard let means that this can fail - the else is executed on failure
        guard let url = URL(string: baseUrl + path)
        else {
            print("Invalid URL")
            // call completion function on null
            completion(nil)
            return
        }
        print(url.self)
        let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        if let response: SearchResults = self.parseJson(json: data) {
                            // call completion function on the response data
                            completion(response.results)
                        } else {
                            // call completion function on nil
                            completion(nil)
                        }
                    }
                    // starts the request
                }.resume()
    }
    
    func getBookDetails(key: String, completion: @escaping (BookDetailsModel?) -> Void ) {
        // the completion parameter is a function
        // it dictates what to do on completion of the response
        // in this case, this means updating data if successful
        // and passing in nil means faliure
        
        let path = "/volumes/\(key)"
        
        // the guard let means that this can fail - the else is executed on failure
        guard let url = URL(string: baseUrl + path)
        else {
            print("Invalid URL")
            // call completion function on null
            completion(nil)
            return
        }
        //print(url.self)
        let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        if let response: BookDetailsModel = self.parseJson(json: data) {
                            // call completion function on the response data
                            completion(response)
                        } else {
                            // call completion function on nil
                            completion(nil)
                        }
                    }
                    // starts the request
                }.resume()
    }
    
    private func parseJson<T: Decodable>(json: Data) -> T? {
        let decoder = JSONDecoder()
            
        do {
            let searchResponse = try decoder.decode(T.self, from: json)
            // if decoding the json is successful
            return searchResponse
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError)")
        }
        
        return nil
         
    }
}
