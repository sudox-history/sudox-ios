//
//  deeplinkNavigator.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit

//класс-навигатор, который будет открывать соответствующий экран приложения в зависимости от DeeplinkType:
class DeeplinkNavigator {
    
    static let shared = DeeplinkNavigator()
    private init() { }
    
    var alertController = UIAlertController()
    
    //В методе proceedToDeeplink мы пробегаем по разным DeeplinkType и определяем, какой alert нужно отобразить
    func proceedToDeeplink(_ type: DeeplinkType) {
        switch type {
        case .activity:
            displayAlert(title: "Activity")
        case .messages(.root):
            displayAlert(title: "Messages Root")
        case .messages(.details(id: let id)):
            displayAlert(title: "Messages Details \(id)")
        case .newListing:
            displayAlert(title: "New Listing")
        case .request(id: let id):
            displayAlert(title: "Request Details \(id)")
   
        }
    }
    
    private func displayAlert(title: String) {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        alertController.title = title
        
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            if vc.presentedViewController != nil {
                alertController.dismiss(animated: false, completion: {
                    vc.present(self.alertController, animated: true, completion: nil)
                    print("present alert")
                })
            } else {
                vc.present(alertController, animated: true, completion: nil)
                print("present alert")
            }
        }
        else{
            print("problem presenting alert")
        }
    }
}
