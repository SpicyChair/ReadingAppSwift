//
//  DiscoverScreenStateController.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 08/11/2022.
//

import Foundation

class DiscoverScreenStateController: ObservableObject {
    
    let recommender: Recommendations = Recommendations()
    @Published var text: String = ""
    
    @Published var mostFrequentAuthor = ""
    @Published var mostFrequentGenre = ""
    
    func getMostFrequentAuthorAndGenre(library: [BookDetailsModel]) {
        
        
        
        var authors: [String] = []
        var genres: [String] = []
        
        for book in library {
            // go through each book
            // add book author to author array
            // add categories to genres array
            authors.append(contentsOf: book.volumeInfo.authors)
            genres.append(contentsOf: book.volumeInfo.categories)
        }
        
        // get the first (index 0) item from the recommender class
        self.mostFrequentAuthor = recommender.countAndGetTopN(arr: authors, n: 1)[0]
        self.mostFrequentGenre = recommender.countAndGetTopN(arr: genres, n: 1)[0]
    }
    
    func getDescriptionTags() -> [String] {
        return recommender.tagAndGetTopN(text: text, n: 5)
    }
    
    func reset() {
        mostFrequentAuthor = ""
        mostFrequentGenre = ""
        text = ""
    }
    
    
    
    

}
