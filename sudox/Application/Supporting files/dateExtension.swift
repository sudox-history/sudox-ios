//
//  dateExtension.swift
//  sudox
//
//  Created by Иван Лобанов on 11/05/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import UIKit

extension Date {
    //MARK: helper
    //https://stackoverflow.com/a/46668669/11763936
    //https://stackoverflow.com/a/57832355/11763936 On Swift 5 use the RelativeDateTimeFormatter
    
    
    //MARK: ForUsers
    func timeAgoSinceDateForUsers(nowTime: Date) -> String {
        //повторяющиеся переменные
        let seenString = "seen"
        
        
        let calendar = Calendar.current
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = nowTime
        
        // Estimation
        // Year
        
        if let interval = calendar.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d M y"
            dateFormatter.locale = Locale.current
            let date = dateFormatter.string(from: fromDate)
            return "\(seenString) \(date) \(atTimeString(date: fromDate))"
        }
        
        // Month
        //        if let interval = calendar.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
        //
        //            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        //        }
        
        // Day
        if let interval = calendar.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            if interval == 1 {
                return "\(yesterday())  \(atTimeString(date: fromDate))"
            }
            if interval <= 7 {
                if calendar.isDateInWeekend(fromDate) == true {//Условие: Событие, которое произошло более суток назад, но меньше недели
                    let onLabel = "on" //переменная из документации
                    return "\(seenString) \(onLabel) \(getWeekdayString(date: fromDate)) \(atTimeString(date: fromDate))"
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "d MMM"
                    dateFormatter.locale = Locale.current
                    let mouth = dateFormatter.string(from: fromDate)
                    return "\(seenString) \(mouth) \(atTimeString(date: fromDate))"
                }
            }
            // if more then 7 days
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            dateFormatter.locale = Locale.current
            let mouth = dateFormatter.string(from: fromDate)
            return "\(seenString) \(mouth) \(atTimeString(date: fromDate))"
        }
        
        // Hours
        if let interval = calendar.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            if calendar.isDate(fromDate, inSameDayAs: toDate) == true {
                if interval <= 12 {
                    let formatter = RelativeDateTimeFormatter()
                    return "\(seenString) \(formatter.localizedString(from: DateComponents(hour: -interval)))" // "1 hour ago"
                } else {
                    return "\(seenString) \(atTimeString(date: fromDate))" // at чч:мм 15:05 3:05 AM
                }
            } else {
                return "\(seenString) \(yesterday()) \(atTimeString(date: fromDate))"
            }
        }
        
        // Minute
        if let interval = calendar.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            let minAgo = "minutes ago"
            return "\(seenString) \(interval) \(minAgo)"
        }
        
        // less then minute
        let justNowString = "just now"
        return "\(seenString) \(justNowString)"
    }
    
    //MARK: ForPosts
    func timeAgoSinceDateForPosts(nowTime: Date) -> String {
        let calendar = Calendar.current
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = nowTime
        
        // Estimation
        // Year
        
        if let interval = calendar.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d M y"
            dateFormatter.locale = Locale.current
            let date = dateFormatter.string(from: fromDate)
            return "\(date) \(atTimeString(date: fromDate))"
        }
        
        // Month
        //        if let interval = calendar.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
        //
        //            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        //        }
        
        // Day
        if let interval = calendar.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            if interval == 1 {
                return "\(yesterday()) \(atTimeString(date: fromDate))"

            }
            if interval <= 7 {
                if calendar.isDateInWeekend(fromDate) == true {//Условие: Событие, которое произошло более суток назад, но меньше недели
                    let onLabel = "on" //переменная из документации
                    return "\(onLabel) \(getWeekdayString(date: fromDate)) \(atTimeString(date: fromDate))"
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "d MMM"
                    dateFormatter.locale = Locale.current
                    let mouth = dateFormatter.string(from: fromDate)
                    return "\(mouth) \(atTimeString(date: fromDate))"
                }
            }
            // if more then 7 days
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            dateFormatter.locale = Locale.current
            let mouth = dateFormatter.string(from: fromDate)
            return "\(mouth) \(atTimeString(date: fromDate))"
        }
        
        // Hours
        if let interval = calendar.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            if calendar.isDateInToday(fromDate) == true {
                if interval <= 12 {
                    let formatter = RelativeDateTimeFormatter()
                    return formatter.localizedString(from: DateComponents(hour: -interval)) // "1 hour ago"
                } else {
                    return atTimeString(date: fromDate) // чч:мм 15:05 3:05 AM
                }
            } else {
                return "\(yesterday()) \(atTimeString(date: fromDate))"
            }
        }
        
        // Minute
        if let interval = calendar.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            let minAgo = "minutes ago"
            return "\(interval) \(minAgo)"
        }
        
        // less then minute
        let justNowString = "just now"
        return justNowString
    }
    //MARK: ForDialogue
    func timeAgoSinceDateForDialogue(nowTime: Date) -> String {
        let calendar = Calendar.current
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = nowTime
        
        // Estimation
        // Year
        if let interval = calendar.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            let yearLetter = "y"
            return "\(interval)\(yearLetter)"
        }
        
        // Month
        //        if let interval = calendar.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
        //
        //            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        //        }
        
        // Day
        if let interval = calendar.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            if interval == 1 {
                return yesterday()
                //коммент на случай проблем с локализацией
                
                //                let dateFormatter = DateFormatter()
                //                dateFormatter.dateStyle = .long
                //                dateFormatter.timeStyle = .none
                //                dateFormatter.locale = Locale.current
                //
                //                dateFormatter.doesRelativeDateFormatting = true
                //                let yestdString = dateFormatter.string(from: fromDate)
                //                return yestdString
            }
            if interval <= 7 {
                if calendar.isDateInWeekend(fromDate) == true {
                    return getWeekdayString(date: fromDate)
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "d MMM"
                    dateFormatter.locale = Locale.current
                    return dateFormatter.string(from: fromDate)
                }
            }
            // if more then 7 days
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            dateFormatter.locale = Locale.current
            return dateFormatter.string(from: fromDate)
        }
        
        // Hours
        if let interval = calendar.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            if calendar.isDateInToday(fromDate) == true {
                let hoursLetter = "h"
                return "\(interval)\(hoursLetter)"
            } else {
                return yesterday()
            }

        }
        
        // Minute
        if let interval = calendar.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            return "\(interval)" + "m"
        }
        
        // less then minute
        return "now"
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func yesterday() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.localizedString(from: DateComponents(day: -1)) // "yesterday"
    }
    
    func getWeekdayString(date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale.current
        let weekDay = dateFormatter.string(from: date)
        return weekDay
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
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//extension under this text sample
//Date.today()                                  // Oct 15, 2019 at 9:21 AM
//Date.today().next(.monday)                    // Oct 21, 2019 at 9:21 AM
//Date.today().next(.sunday)                    //  Oct 20, 2019 at 9:21 AM
//
//
//Date.today().previous(.sunday)                // Oct 13, 2019 at 9:21 AM
//Date.today().previous(.monday)                // Oct 14, 2019 at 9:21 AM
//
//Date.today().previous(.thursday)              // Oct 10, 2019 at 9:21 AM
//Date.today().next(.thursday)                  // Oct 17, 2019 at 9:21 AM
//Date.today().previous(.thursday,
//                      considerToday: true)    // Oct 10, 2019 at 9:21 AM
//
//
//Date.today().next(.monday)
//            .next(.sunday)
//            .next(.thursday)                  // Oct 31, 2019 at 9:21 AM

extension Date {
    
    static func today(today: Date) -> Date {
        return today
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}
