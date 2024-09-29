//
//  ImageGalleryAppUITests.swift
//  ImageGalleryAppUITests
//
//  Created by Ankit Sharma on 28/09/24.
//

import XCTest

final class ImageGalleryAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        var expectation = XCTestExpectation(description: "Wait for view to load")
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)

        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        
        expectation = XCTestExpectation(description: "Wait for view to load")
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        app.navigationBars["Image Detail"]/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".otherElements[\"Back\"].buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
