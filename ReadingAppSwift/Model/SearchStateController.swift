//
//  SearchStateController.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import Foundation

class SearchStateController: ObservableObject  {
    
    @Published var responses: [SearchResponse] = []
    private let adapter = OpenLibraryAdapter()
    
    var searchFor = "" {
        // when this value changes
        didSet {
            // ask the adapter to get the response from the API
            adapter.getSearchResponse(search: searchFor, completion: updateSearchResponses)
        }
    }
    
    let openLibraryAdapter = OpenLibraryAdapter()
    
    func updateSearchResponses(responses: [SearchResponse]?) {
        let responses = responses?.map {
            return $0
        }
        DispatchQueue.main.async{
            self.responses = responses ?? []
        }
    }
}


