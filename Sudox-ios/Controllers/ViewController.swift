//
//  ViewController.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.02.2020.
//  Copyright © 2020 Nikita Kazantsev. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {
    let reveralingSplashView = RevealingSplashView(iconImage: UIImage(named: "bigLogo")!, iconInitialSize: CGSize(width: 100, height: 100), backgroundColor: UIColor.white)
    var Splash: Int = UserDefaults.standard.integer(forKey: "Splash") {
        didSet {
            UserDefaults.standard.set(Splash, forKey: "Splash")
            UserDefaults.standard.synchronize()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SplashAnimation()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "loginNavController")
        newViewController.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.present((newViewController), animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
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

