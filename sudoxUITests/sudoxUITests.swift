//
//  sudoxUITests.swift
//  sudoxUITests
//
//  Created by Иван Лобанов on 22/04/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import XCTest

class sudoxUITests: XCTestCase {

    var app: XCUIApplication!
        
        override func setUp() {
            // Put setup code here. This method is called before the invocation of each test method in the class.
            
            // In UI tests it is usually best to stop immediately when a failure occurs.
            continueAfterFailure = false
            app = XCUIApplication()
            // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        }

        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testPeopleTabOpens() {
            app.launchArguments.append("isLoggined")
            app.launch()
            
            
            let app = XCUIApplication()
            app.navigationBars["sudox.PeopleView"].buttons["People"].tap()
            
            let scrollViewsQuery = app.scrollViews.otherElements.scrollViews
            let friendRequestsElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Friend Requests")
            friendRequestsElementsQuery.children(matching: .image).matching(identifier: "checkmark").element(boundBy: 0).tap()
            
            let friendRequestsElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Friend Requests").element
            friendRequestsElement.tap()
            friendRequestsElement.swipeUp()
            friendRequestsElementsQuery.children(matching: .button).matching(identifier: "chevron.down").element(boundBy: 1).tap()
            friendRequestsElement.tap()
            
            let biglogoElement = scrollViewsQuery.otherElements.scrollViews.otherElements.containing(.image, identifier:"bigLogo").element
            biglogoElement.tap()
            biglogoElement.swipeRight()
                      
            
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
