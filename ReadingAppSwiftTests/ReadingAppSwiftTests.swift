//
//  ReadingAppSwiftTests.swift
//  ReadingAppSwiftTests
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import XCTest
@testable import readaily

class ReadingAppSwiftTests: XCTestCase {

    func testRecommendationsTagAndGetTopNWithOnlyNounInput () throws {
        
        // test the tagging feature
        // the input will be only noun input and will not contain any stopwords
        
        let recommender: Recommendations = Recommendations()
        
        let text = "Recommendation Recommendation Automated Test Test Recommendation Recommendation Automated Test Recommendation Recommendation Automated Test"
        
        let expected = ["Recommendation", "Test"]
        
        let response = recommender.tagAndGetTopN(text: text, n: 2)

        XCTAssert(response == expected)

    }
    
    func testRecommendationsTagAndGetTopNWithMixedInput() throws {
        
        // test the tagging feature
        // the input will be contain stopwords
        
        let recommender: Recommendations = Recommendations()
        
        let text = "The The The The The The The Recommendation The Test Test"
        let expected = ["Test", "Recommendation"]
        
        let response = recommender.tagAndGetTopN(text: text, n: 2)

        XCTAssert(response == expected)

    }
    
    func testRecommendationsGetTopN() throws {
        
        // test the tagging feature
        // the input will be contain stopwords
        
        let recommender: Recommendations = Recommendations()
        
        let authors = ["Bill Bryson", "Bill Bryson", "Bill Bryson","Ted Chiang","Hans Rosling", "Hans Rosling"]
        let expected = ["Bill Bryson", "Hans Rosling", "Ted Chiang"]
        let response = recommender.countAndGetTopN(arr: authors, n: 3)
        XCTAssert(response == expected)

    }
    
    func testRecommendationsEmptyString() throws {
        
        // test the tagging feature
        // the input is empty - expect an empty array
        let recommender: Recommendations = Recommendations()
        
        let text = ""
        let expected : [String] = []
        let response = recommender.tagAndGetTopN(text: text, n: 1)
        XCTAssert(response == expected)

    }
    
    func testRecommendationsOnlyStopWords() throws {
        
        // test the tagging feature
        // the input is only stopwords - expect an empty array
        let recommender: Recommendations = Recommendations()
        
        let text = "The The The The The"
        let expected : [String] = []
        let response = recommender.tagAndGetTopN(text: text, n: 1)
        XCTAssert(response == expected)

    }
    
    func testRecommendationsNGreaterThanWords() throws {
        
        // test the tagging feature
        // n greater than word count - expect an empty dictionary
        let recommender: Recommendations = Recommendations()
        
        let text = "This input will have less than N words!"
        let expected : [String] = []
        let response = recommender.tagAndGetTopN(text: text, n: 999)
        XCTAssert(response == expected)

    }
    
    func testSearchResultsNotEmpty() throws {
        
        // test that search yields results
        
        let state = SearchStateController()
        
        // search for Bill Bryson
        
        state.searchFor = "Bill Bryson"
        
        //wait for search to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // assert that results are not empty
            XCTAssert(!state.results.isEmpty)
        })

    }

    
    func testSearchResultBook() throws {
        
        // test that search yields results with valid non-null properties
        
        let state = SearchStateController()
        
        // search for A Walk in the Woods
        
        state.searchFor = "A Walk in the Woods"

        //wait for search to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            //assert that all properties are not nil
            let book = state.results[0]
            XCTAssertNotNil(book.saleInfo)
            XCTAssertNotNil(book.volumeInfo)
            XCTAssertNotNil(book.link)
            XCTAssertNotNil(book.key)
        })

    }
    
    func testSearchResultBookHasDetails() throws {
        
        // test that search yields results has details
        
        let state = SearchStateController()
        
        // search for A Walk in the Woods
        
        state.searchFor = "A Walk in the Woods"

        //wait for search to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            
            let book = state.results[0]
            XCTAssertNotNil(book.saleInfo)
            XCTAssertNotNil(book.volumeInfo)
            XCTAssertNotNil(book.link)
            XCTAssertNotNil(book.key)
        })

    }
    
    func testBookDetailsModelCorrect() throws {
        
        // test that search yields results
        // tests that the result data within structs is not null and valid
        
        let state = SearchStateController()
        
        // search for A Walk in the Woods
        
        state.searchFor = "A Walk in the Woods"

        //wait for search to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            
            let book:BookDetailsModel = state.results[0]
            let data = book.volumeInfo
            
            // test for essential information
            
            XCTAssert(data.title.lowercased() == "a walk in the woods")
            XCTAssert(data.authors[0].lowercased() == "bill bryson")
            XCTAssertNotNil(data.pageCount)
        })

    }
    
    func testSearchForArbitraryStringReturnsNothing() throws {
        
        // test that search yields no results for a random string
        
        let state = SearchStateController()
        
        // search for arbitrary string
        
        state.searchFor = "//$3£=+-_"

        
        //wait for search to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // assert that results are empty
            XCTAssert(state.results.isEmpty)
        })
    }
    
    func testSearchForEmptyStringReturnsNothing() throws {
        
        // test that searching for an empty string returns nothing
        
        let state = SearchStateController()
        
        // search for empty string
        
        state.searchFor = ""

        
        //wait for search to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // assert that results are empty
            XCTAssert(state.results.isEmpty)
        })
    }
    
    func testCanGetFirestoreUsers() throws {
        
        let adapter: FirestoreAdapter = FirestoreAdapter()
        adapter.getUsers()
        
        //wait for refresh to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // assert that users are not empty
            XCTAssert(!adapter.users.isEmpty)
        })
        
        
    }
    func testFirestoreUsersNotNull() throws {
        
        let adapter: FirestoreAdapter = FirestoreAdapter()
        adapter.getUsers()
        
        //wait for refresh to finish before using XCTAssert
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // assert that users are not empty
            XCTAssert(!adapter.users.isEmpty)
            
            // get the user's data
            if let user = adapter.users.first {
                let data = user.value
                // assert it is not nil
                XCTAssertNotNil(data.pageProgress)
                XCTAssertNotNil(data.name)
                XCTAssertNotNil(data.uid)
            }
        })
    }
}
