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
        mostFrequentAuthor = recommender.getMostFrequentAuthor(library: library)
        mostFrequentGenre = recommender.getMostFrequentGenre(library: library)
    }
    
    func getDescriptionTags() -> [String] {
        return recommender.tagAndGetTopN(text: text, n: 5)
    }
    
    
    
    

}
