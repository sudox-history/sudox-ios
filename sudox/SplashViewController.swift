//
//  SplashViewController.swift
//  sudox
//
//  Created by Иван Лобанов on 22/04/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//


import UIKit
import RevealingSplashView
class SplashViewController: UIViewController  {
    
    
    let reveralingSplashView = RevealingSplashView(iconImage: UIImage(named: "bigLogo")!, iconInitialSize: CGSize(width: 100, height: 100), backgroundColor: UIColor.systemBackground)
    var Splash: Int = UserDefaults.standard.integer(forKey: "Splash") {
        didSet {
            UserDefaults.standard.set(Splash, forKey: "Splash")
            UserDefaults.standard.synchronize()
        }
    }
    private func chooseVC () -> UIViewController {
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
            
            print("LOGGED_IN")
            return MainTabBarController()
        } else {
            print("NOT LOGGED_IN")
            let loginVc = loginNavController(rootViewController: loginPhoneFormVC())
            return loginVc
        }
    }
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidAppear(_ animated: Bool) {

        SplashAnimation()

        let newViewController = chooseVC()
        
        newViewController.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.present(newViewController, animated: true, completion: nil)     // У нас раньше так открывался
        }
    }
    
    
    
    func SplashAnimation() {
        view.addSubview(reveralingSplashView)
        let launchedBefore = UserDefaults.standard.bool(forKey: "vcLaunched")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            UserDefaults.standard.set(true, forKey: "vcLaunched")
            Splash = 1
        }
        switch Splash {
        case 1:
            reveralingSplashView.animationType = .heartBeat
        case 2:
            reveralingSplashView.animationType = .popAndZoomOut
        case 3:
            reveralingSplashView.animationType = .rotateOut
        case 4:
            reveralingSplashView.animationType = .squeezeAndZoomOut
        case 5:
            reveralingSplashView.animationType = .twitter
        case 6:
            reveralingSplashView.animationType = .swingAndZoomOut
        case 7:
            reveralingSplashView.animationType = .woobleAndZoomOut
        default:
            reveralingSplashView.animationType = .heartBeat
        }
        
        reveralingSplashView.startAnimation()
        if Splash == 1 {
            reveralingSplashView.finishHeartBeatAnimation()
        }
        Splash = Splash + 1
        if Splash == 8 {
            Splash = 1
        }
    }

}

