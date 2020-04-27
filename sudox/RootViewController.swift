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
        //    func showLogin() {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let new = storyboard.instantiateViewController(withIdentifier: "loginNavController")
        //
//        let keyWindow = application.windows.first { $0.isKeyWindow == true }
//        keyWindow?.rootViewController = new
        return new
    }

    
}

//class RootViewController :UIViewController {
//    var currentProfile = ProfileType.host
//    private var current: UIViewController
//
//    init() {
//        current = ViewController()
//        super.init(nibName:  nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureFor(profileType: currentProfile)
//
//        addChild(current)
//        current.view.frame = view.bounds
//        view.addSubview(current.view)
//        current.didMove(toParent: self)
//
//
//    }
//
//    //Этот метод мы будем вызывать из нашего ViewController’а: когда пользователь меняет профиль, шорткаты будут перенастроены в соответствии с новым типом профиля:
//    func configureFor(profileType: ProfileType) {
//        title = profileType.rawValue
//        ShortcutParser.shared.registerShortcuts(for: profileType)
//    }
//
//    func switchToMainScreen() {
//        let mainViewController = testVC2()//mainTabBarController()
//
//       // let mainScreen = MainNavigationController(rootViewController: mainViewController)
//
//        animateFadeTransition(to: mainViewController)
//
//}
//
//    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
//        //let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
//        current.willMove(toParent: nil)
//        addChild(new)
//        transition(from: current, to: new, duration: 0.3, options: [], animations: {
//           new.view.frame = self.view.bounds
//        }) { completed in
//            self.current.removeFromParent()
//            new.didMove(toParent: self)
//           self.current = new
//           completion?()
//        }
//       }
//    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
//
//        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
//        current.willMove(toParent: nil)
//        addChild(new)
//        new.view.frame = initialFrame
//
//        transition(from: current, to: new, duration: 0.3, options: [], animations: {
//            new.view.frame = self.view.bounds
//        }) { completed in
//            self.current.removeFromParent()
//            new.didMove(toParent: self)
//            self.current = new
//            completion?()
//        }
//    }
//
//
//}
