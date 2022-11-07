//
//  Recommendations.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 07/11/2022.
//

import Foundation
import NaturalLanguage

class Recommendations {
    
    let tokenizer: NLTokenizer = NLTokenizer(unit: .word)
    

    func tokenize(text: String) {
        
        tokenizer.string = text
        
        
        // count of all the words in the string
        var count: [String: Int] = [:]
        
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { tokenRange, _ in
            
            let token = text[tokenRange].lowercased()
            // stop words are common words and phrases
            // remove these to find key words
            if !(stop_words.contains(token)) {
                // if not existing
                // create a new entry with value 1
                
                // else
                // get the count and then add one to it
                count[token] = (count[token] ?? 0) + 1
            }
            
            return true
        }
        // sort by value
        print(count.sorted { $0.1 > $1.1 })
    }
    
    // STOP WORDS
    
    
}
