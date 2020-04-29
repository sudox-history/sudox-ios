//
//  Extensions.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 12/02/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
struct myColors {
    static let NativeBlue = UIColor(red:0/255, green:122/255, blue:255/255, alpha:1)
}

class NativeButton: UIButton {
    
    private func setup() {
        backgroundColor = myColors.NativeBlue
        setTitleColor(UIColor.white, for: .normal)
        //titleLabel?.font = UIFont.systemFont(ofSize: 22)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.contentEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? UIColor.lightGray.withAlphaComponent(0.5) : myColors.NativeBlue.withAlphaComponent(1.0)
        }
    }
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
            
        }
    }
}
extension UILabel {
    func setUpMainLabel() {
        // заменить на open sans
        self.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.textAlignment = .center
        //self.textColor = getColor().labelColor
    }
    func setUpDescriptionLabel() {
        // заменить на open sans
        //self.font = UIFont.systemFont(ofSize: 14.0)
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .left
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        
        self.textColor = getColor().labelColor
        
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}
extension Date { // time ago for

    func timeAgoSinceDate() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        if let interval = Calendar.current.dateComponents([.second], from: fromDate, to: toDate).second, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "second ago" : "\(interval)" + " " + "seconds ago"
        }

        return "a moment ago"
    }
}
extension UIImageView {

   func setRounded() {
    let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}

extension NSDate {
    
    /// This function returns boolean value indicating if token has expired .
    ///
    /// ```
    /// isExpired(dateToCompare, expirationTime) // true
    /// ```
    /// - Returns: returns boolean value indicating if token has expired .
    func isExpired(dateToCompare: NSDate, expirationTime: TimeInterval) -> Bool {
        
        // seconds between two dates
        let dateSubstraction = (NSInteger(self.timeIntervalSince(dateToCompare as Date )) / 60 ) % 60
        
        if (dateSubstraction <= NSInteger(expirationTime)) // if
        {
            return false
        }
        
        return true
    }
}
