//
//  BookSaleInfo.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 27/09/2022.
//

import Foundation

struct BookSaleInfo: Codable {
    let purchaseLink: String
    let isForSale: Bool
    let price: Double
    let currency: String
    
    private struct rawBookSaleInfo: Decodable {
        struct ListPrice: Decodable {
            let amount: Double?
            let currencyCode: String?
        }
        
        let listPrice: ListPrice?
        let buyLink: String?
        let saleability: String?
    }
    
    init(from decoder: Decoder) throws {
        let rawBookSale = try rawBookSaleInfo(from: decoder)
        
        purchaseLink = rawBookSale.buyLink ?? ""
        isForSale = rawBookSale.saleability == "FOR_SALE"
        price = rawBookSale.listPrice?.amount ?? 0
        currency = rawBookSale.listPrice?.currencyCode ?? ""
    }
}
