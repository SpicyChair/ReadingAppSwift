//
//  Recommendations.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 07/11/2022.
//

import Foundation
import NaturalLanguage

class Recommendations {
    
    let tagger: NLTagger = NLTagger(tagSchemes: [.lexicalClass])
    
    // options to be used with the tagger
    // option names are self explanatory
    
    let taggerOptions: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .omitOther, .joinNames, .joinContractions]
    
    
    
    
    func tagAndGetTopN(text: String, n: Int) -> [String] {
        
        // count of all the words in the string
        var count: [String: Int] = [:]
        
        tagger.string = text
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: taggerOptions) {
            tag, tokenRange in
            
            if let tag = tag?.rawValue {
                
                // only count if the tag's type is Noun
                
                if tag == "Noun" {
                    
                    // stop words are common words and phrases
                    // remove these to find key words\
                    
                    let c = "\(text[tokenRange])".lowercased()
                    
                    
                    if !(stop_words.contains(c)) && c.count > 2 {
                        
                        // if not existing
                        // create a new entry with value 1
                        
                        // else
                        // get the count and then add one to it
                        
                        count[c] = (count[c] ?? 0) + 1
                    }
                }
                
            }
            return true
        }
        
        // sorted returns a tuple array
        
        let sorted = count.sorted(by: { $0.1 > $1.1 })
        
        // get first n elements
        
        var results: [String] = []
        
        if sorted.count >= n {
            for (tag, _) in sorted[..<n] {
                
                results.append(tag.capitalized)
            }
        }
        
        
        
        return results
    }
    
    
    // T needs to conform to hashable so that it can be used in the count dict
    func countAndGetTopN <T : Hashable> (arr: [T], n: Int) -> [T] {
        
        var count:[T: Int] = [:]
        
        for item in arr {
            // count the items in the array
            // if item doesnt exist already, create new K:V pair
            count[item] = (count[item] ?? 0) + 1
        }
        
        // sorted returns a tuple array
        
        let sorted = count.sorted(by: { $0.1 > $1.1 })
        
        // get first n elements
        
        var results: [T] = []
        
        if sorted.count >= n {
            for (item, _) in sorted[..<n] {
                
                results.append(item)
            }
        }
        
        return results
    }
    
}


