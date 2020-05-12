//
//  timeTests.swift
//  sudoxTests
//
//  Created by Иван Лобанов on 11/05/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import XCTest
@testable import sudox

class timeTestsForDialogue: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //MARK:testsForDialogue
    func testNowForDialogue() {
        let userCalendar = Calendar.current;var dateComponents = DateComponents();dateComponents.year = 2020;dateComponents.month = 5;dateComponents.day = 7;dateComponents.hour = 13;dateComponents.minute = 30;dateComponents.second = 28;// user calendar
        //13:30:30 7.5.2020
        let nowTime = userCalendar.date(from: dateComponents)!
        var dateComponents1 = DateComponents()
        dateComponents1.hour = 13
        dateComponents1.minute = 30
        dateComponents1.second = 28
        dateComponents1.day = 7
        dateComponents1.month = 5
        dateComponents1.year = 2020
        let someDateTime = userCalendar.date(from: dateComponents1)!
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: nowTime), "now")
    }
    func test1MinForDialogue() {
        let userCalendar = Calendar.current;var dateComponents = DateComponents();dateComponents.year = 2020;dateComponents.month = 5;dateComponents.day = 7;dateComponents.hour = 13;dateComponents.minute = 30;dateComponents.second = 28;// user calendar
        //13:30:30 7.5.2020
        let nowTime = userCalendar.date(from: dateComponents)!
        var dateComponents1 = DateComponents()
        dateComponents1.hour = 13
        dateComponents1.minute = 29
        dateComponents1.second = 28
        dateComponents1.day = 7
        dateComponents1.month = 5
        dateComponents1.year = 2020
        let someDateTime = userCalendar.date(from: dateComponents1)!
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: nowTime), "1m")
    }
    func test5HourForDialogue() {
        let someDateTime = Date().addingTimeInterval(-18000)
        let nowTime = Date()
        var answer : String = ""

        if Calendar.current.isDateInToday(someDateTime) {
            answer = "5h"
        } else {answer = "yesterday"}
        
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: nowTime), answer)
    }
    func test13HourForDialogue() {
        let someDateTime = Date().addingTimeInterval(-46800)
        let nowTime = Date()
        var answer : String = ""

        if Calendar.current.isDateInToday(someDateTime) {
            answer = "13h"
        } else {answer = "yesterday"}
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: nowTime), answer)
    }
    func testYesterdayForDialogue() {
        let userCalendar = Calendar.current;var dateComponents = DateComponents();dateComponents.year = 2020;dateComponents.month = 5;dateComponents.day = 7;dateComponents.hour = 13;dateComponents.minute = 30;dateComponents.second = 28;// user calendar
        //13:30:30 7.5.2020
        let nowTime = userCalendar.date(from: dateComponents)!
        var dateComponents1 = DateComponents()
        dateComponents1.hour = 16
        dateComponents1.minute = 29
        dateComponents1.second = 28
        dateComponents1.day = 6
        dateComponents1.month = 5
        dateComponents1.year = 2020
        let someDateTime = userCalendar.date(from: dateComponents1)!
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: nowTime), "yesterday")
    }
    func test2DaysForDialogue() {
        
        let someDateTime = Date().addingTimeInterval(-172800)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale.current
        var weekDay: String = ""
        if Calendar.current.isDateInWeekend(someDateTime) {
            weekDay = dateFormatter.string(from: someDateTime)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            dateFormatter.locale = Locale.current
            weekDay = dateFormatter.string(from: someDateTime)
        }
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: Date()), weekDay)
    }
    func testLastWeekForDialogue() {
        let someDateTime = Date().addingTimeInterval(-691200)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale.current
        let weekDay = dateFormatter.string(from: someDateTime)
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: Date()), weekDay)
    }
    func testMoreThen1YearForDialogue() {
        let someDateTime = Date().addingTimeInterval(-50000000)
        XCTAssertEqual(someDateTime.timeAgoSinceDateForDialogue(nowTime: Date()), "1y")
    }
    
}
