//
//  DiscoverScreenStateController.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 08/11/2022.
//

import Foundation

class DiscoverScreenStateController: ObservableObject {
    
    let recommender: Recommendations = Recommendations()
    var text: String = ""
    
    func getTags() -> [String] {
        return recommender.tagAndGetTopN(text: text, n: 5)
    }
    
}
