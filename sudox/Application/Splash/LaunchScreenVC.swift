//
//  LaunchScreenVC.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 15/02/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import RevealingSplashView
class LaunchScreen: UIViewController {

override func viewDidLoad() {
    super.viewDidLoad()
    
    //Initialize a revealing Splash with with the iconImage, the initial size and the background color
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "twitterLogo")!, iconInitialSize: CGSize(width: 70, height: 70), backgroundImage: UIImage(named: "BackgroundImage")!)

    revealingSplashView.useCustomIconColor = false
    revealingSplashView.iconColor = UIColor.red

    //Adds the revealing splash view as a sub view
    self.view.addSubview(revealingSplashView)

    //Starts animation
    revealingSplashView.startAnimation(){
        print("Completed")
    }

}
}
