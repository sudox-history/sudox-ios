//
//  timeTestsForPosts.swift
//  sudoxTests
//
//  Created by Иван Лобанов on 12/05/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import XCTest
@testable import sudox

class timeTestsForPosts: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    func atTimeString(date: Date) -> String {
        //повторяющиеся переменные локализации
        let atLabel = "at" // at/в (чч:мм)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        let timeString = dateFormatter.string(from: date)
        return "\(atLabel) \(timeString)"
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //MARK:testsForPosts
    func testNowForPosts() {
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
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: nowTime), "just now")
    }
    func test1MinForPosts() {
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
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: nowTime), "1 minutes ago")
    }
    func test5HourForPosts() {
        let someDateTime = Date().addingTimeInterval(-18000)
        let nowTime = Date()
        var answer : String = ""

        if Calendar.current.isDateInToday(someDateTime) {
            answer = "5 hours ago"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale.current
            let timeString = dateFormatter.string(from: someDateTime)
            answer = "yesterday at \(timeString)"
            
        }
        
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: nowTime), answer)
    }
    func test14HourForPosts() {
        let someDateTime = Date().addingTimeInterval(-46800)
        let nowTime = Date()
        var answer : String = ""

        if Calendar.current.isDateInToday(someDateTime) {
            answer = atTimeString(date: someDateTime)
        } else {
            answer = "yesterday \(atTimeString(date: someDateTime))"
            
        }
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: nowTime), answer)
    }
    func testYesterdayForPosts() {
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
        let a = "yesterday \(atTimeString(date: someDateTime))"
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: nowTime), a)
    }
    func test2DaysForPosts() {
        let someDateTime = Date().addingTimeInterval(-172800)
        var answer: String = ""
        if Calendar.current.isDateInWeekend(someDateTime) == true {//Условие: Событие, которое произошло более суток назад, но меньше недели
            let onLabel = "on" //переменная из документации
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E"
            dateFormatter.locale = Locale.current
            let weekDay = dateFormatter.string(from: someDateTime)
            answer = "\(onLabel) \(weekDay) \(atTimeString(date: someDateTime))"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            dateFormatter.locale = Locale.current
            let mouth = dateFormatter.string(from: someDateTime)
            answer = "\(mouth) \(atTimeString(date: someDateTime))"
        }
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: Date()), answer)
    }
    func testLastWeekForPosts() {
        let someDateTime = Date().addingTimeInterval(-691200)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale.current
        let dayAndMouth = dateFormatter.string(from: someDateTime)
        let answer = "\(dayAndMouth) \(atTimeString(date: someDateTime))"
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: Date()), answer)
    }
    func testMoreThen1YearForPosts() {
        let someDateTime = Date().addingTimeInterval(-31622400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d M y"
        dateFormatter.locale = Locale.current
        let date = dateFormatter.string(from: someDateTime)
        let answer =  "\(date) \(atTimeString(date: someDateTime))"
        XCTAssertEqual(someDateTime.timeAgoSinceDateForPosts(nowTime: Date()), answer)
    }
    

}
