//
//  BamOnGitHubUITests.swift
//  BamOnGitHubUITests
//
//  Created by Geraldine on 09/07/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import XCTest

class BamOnGitHubUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
         app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForCellExistence() {
        let firstCell = app.tables.element.cells.firstMatch
        XCTAssertTrue(firstCell.exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
