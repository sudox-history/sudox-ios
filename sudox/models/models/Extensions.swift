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
    
    func showAlertMessage(errorCode: Int) {
        
        let err: Error = AppError.authorization(type: AppError.Enums.AuthorizationError(rawValue: errorCode)!)
        
        let alert = UIAlertController(title: String(errorCode), message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
           alert.view.superview?.isUserInteractionEnabled = true
           alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissErrorOnTapOutside)))
        })
    }
    
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
           alert.view.superview?.isUserInteractionEnabled = true
           alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissErrorOnTapOutside)))
        })
    }
    
    /// функция, убирающая alert по нажатию (тапу) извне
    ///
    /// ```
    /// dismissOnTapOutside()
    /// ```
    ///
    /// - Warning: для ее работы необходимо вставить функцию в selector
    ///
    /// ```
    /// alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
    /// ```
    /// - Returns: Void
    @objc func dismissErrorOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
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
            if interval == 1 {
                return "yesterday"
            }
            if interval <= 7 {
                
            }
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval <= 12 ? "\(interval)" + " " + "h" : "\(interval)" + " " + "h"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return "\(interval)" + "m"
        }
        
        // less then minute
        return "now"
    }
}
extension UIImageView { // закругление объекта

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

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
@IBDesignable class PaddingLabel: UILabel { // класс для скругления лейбла с непрочитанными сообщениями

    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
