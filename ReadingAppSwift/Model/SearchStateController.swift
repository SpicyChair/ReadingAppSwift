//
//  SearchStateController.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

class SearchStateController: ObservableObject  {
    
    @Published var results: [BookDetailsModel] = []
    private let adapter = GoogleBooksAdapter()
    
    var searchFor = "" {
        // when this value changes
        didSet {
            // ask the adapter to get the response from the API
            adapter.getSearchResponse(search: searchFor, completion: updateSearchResults)
        }
    }
    
    let openLibraryAdapter = GoogleBooksAdapter()
    
    func updateSearchResults(results: [BookDetailsModel]?) {
        let results = results?.map {
            return $0
        }
        DispatchQueue.main.async{
            self.results = results ?? []
        }
        
    }
}


