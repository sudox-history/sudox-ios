//
//  RootViewController.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 22/02/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//
import UIKit
import SwiftKeychainWrapper
import Starscream

final class RootRouter {
    
    var Registrationsocket = Network.shared
    func chooseVC () -> UIViewController { //
        let new: UIViewController
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
            print("LOGGED_IN")
            new = MainTabBarController()
        } else {
            print("NOT LOGGED_IN")

            
            let loginVc = loginNavController(rootViewController: loginPhoneFormVC())
            new = loginVc
        }
        return new
    }

    
}
