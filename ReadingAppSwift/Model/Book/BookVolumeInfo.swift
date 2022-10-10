//
//  BookVolumeInfo.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 27/09/2022.
//

import Foundation

struct BookVolumeInfo: Codable, Hashable {
    // internal class so unwrapping of optionals not neccessary thoughout app
    // all fields here are non optional
    let title: String
    let description: String
    let authors: [String]
    let publishedDate: String
    let coverImage: String
    let pageCount: Int
    let language: String
    
    init(from decoder: Decoder) throws {
        let rawBookDetails = try RawBookDetailsModel(from: decoder)
        
        // unwrapping takes place here
        self.title = rawBookDetails.title ?? "No title"
        self.description = rawBookDetails.description ?? "No description"
        self.authors = rawBookDetails.authors ?? ["No author"]
        self.publishedDate = rawBookDetails.publishedDate ?? "No publish date"
        self.pageCount = rawBookDetails.pageCount ?? 0
        self.language = rawBookDetails.language ?? "No language"
        
        
        if let cover = rawBookDetails.coverImage {
            // check if cover exists in storage
            self.coverImage = cover
        } else {
            // if not, get from API
            self.coverImage = "\(rawBookDetails.imageLinks?.thumbnail?.replacingOccurrences(of: "http", with: "https") ?? "")?key=\(booksApiKey)"
        
        }
        print(self.coverImage)
    }
    
    //horrible-looking struct modelled one to one with the JSON data
    //note all the fields are optional - they will be unwrapped in the init
    private struct RawBookDetailsModel: Decodable {
        let title: String?
        let description: String?
        let publishedDate: String?
        let publisher: String?
        let authors: [String]?
        let pageCount: Int?
        
        // Properties to Allow for Decoding from JSON in Storage
        let coverImage: String?
        // END
        
        // ISBN numbers
        let industryIdentifiers: [IndustryIdentifiers]?
        
        struct IndustryIdentifiers: Decodable {
            let type: String?
            let identifier: String?
        }
        // forward slash divided tags / categories
        // will be split
        let categories: [String]?
        
        let imageLinks: ImageLinks?
        
        struct ImageLinks: Decodable {
            let smallThumbnail: String?
            let thumbnail: String?
        }
        
        let language: String?
    }
}
