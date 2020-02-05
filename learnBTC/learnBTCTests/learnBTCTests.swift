//
//  learnBTCTests.swift
//  learnBTCTests
//
//  Created by 19hk4 on 12/2/18.
//  Copyright © 2018 19hk4. All rights reserved.
//

import XCTest
import UtterKit

@testable import learnBTC

class learnBTCTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSliceTweets() {
        let graph = PriceGraphViewController()
        
        let day : String = "12-1-18"
        let _ = graph.tweetDay(day: day)
        let data = graph.accessTweets()
        let date : String = "12-1-2018 17:25"
        
        XCTAssertTrue(graph.sliceTweets(data: data, date: date).count == 0)
    }
    
    func testTweetDay() {
        let graph = PriceGraphViewController()
        let day : String = "12-01-2018"
        graph.tweetDay(day: day)
        XCTAssertTrue(graph.accessTweets().count != 0)
    }
    
    func testPriceDay() {
        let graph = PriceGraphViewController()
        let day : String = "12-01-2018"
        
        XCTAssertTrue(graph.priceDay(day: day).count != 0)
    }
    
    func testSliceDates() {
        let graph = PriceGraphViewController()
        let day : String = "12-01-2018"
        let values = graph.priceDay(day: day)
        let start = "12-1-2018 17:25"
        let end = "12-1-2018 18:25"
        
        XCTAssertFalse(graph.sliceDates(values: values, start: start, end: end).isEmpty)
    }
    
    func testInitalizeAnalytics() {
        let table = TwitterDataTableViewController()
        let description : [String] = table.testInitalize()
        
        XCTAssertTrue(description[0] == "Volume: 4")
        XCTAssertTrue(description[1] == "Most Frequent: tweet, multiple, of" )
        
    }
    
}
