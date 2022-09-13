//
//  OpenLibraryAdapter.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

class OpenLibraryAdapter {
    // the base url for the openlibrary api
    let baseUrl = "https://openlibrary.org/"
    
    func getSearchResponse(search: String, completion: @escaping ([Book]?) -> Void ) {
        // the completion parameter is a function
        // it dictates what to do on completion of the response
        // in this case, this means updating data if successful
        // and passing in nil means faliure
        
        // creates a path; addPercentEncoding allows for spaces in the search string
        let path = "search.json?title=\(search)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // the guard let means that this can fail - the else is executed on failure
        guard let url = URL(string: baseUrl + path)
        else {
            print("Invalid URL")
            // call completion function on null
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        if let response = self.parseJson(json: data) {
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
    
    private func parseJson(json: Data) -> SearchResponse? {
        let decoder = JSONDecoder()
            
        do {
            let searchResponse = try decoder.decode(SearchResponse.self, from: json)
            // if decoding the json is successful
            return searchResponse
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError)")
        }
        
        return nil
    
         
    }
}
