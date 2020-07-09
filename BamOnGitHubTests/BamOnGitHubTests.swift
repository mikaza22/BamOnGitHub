//
//  BamOnGitHubTests.swift
//  BamOnGitHubTests
//
//  Created by Geraldine on 09/07/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import XCTest
@testable import BamOnGitHub

class BamOnGitHubTests: XCTestCase {
    
    let config = AppConfig()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_API_BaseURLString_IsCorrect() {
        let URLString = config.APIURL
        let expectedURLString = "https://api.github.com/orgs/bamlab/repos"
        XCTAssertEqual(URLString, expectedURLString, "URL does not match expected URL. Expected URLs to match.")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
