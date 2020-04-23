//
//  colors.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 12/02/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static let NativeBlue1 = hexStringToUIColor(hex: "007AFF")
    static let myGray = hexStringToUIColor(hex: "EFEFF4")
    static let myLightGray = hexStringToUIColor(hex: "F8F8F8")
    static let grayBorder = hexStringToUIColor(hex: "E0E0E0").withAlphaComponent(0.6)
    static let NativeGreen = UIColor(red:76/255, green:217/255, blue:100/255, alpha:1)
    static let Red = UIColor(red: 215/255, green: 50/255, blue: 37/255, alpha: 1)
    
    static let globalGreen = hexStringToUIColor(hex: "#00BFA5")
}
struct colors {
    let background : UIColor!
    let labelColor : UIColor!
    let mainColor : UIColor!
    static let currentColors = colors (
        background: UIColor.systemBackground,
        labelColor: UIColor.label,
        mainColor: UIColor.globalGreen
    )
    
    
}

func getColor() -> colors {
    return colors.currentColors
}









// MARK: Функции преобразования цвета

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return .init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
    }
}
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
