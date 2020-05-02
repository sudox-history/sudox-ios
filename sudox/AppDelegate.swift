//
//  AppDelegate.swift
//  sudox
//
//  Created by Иван Лобанов on 22/04/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import UIKit

var IsDebagDevice: Bool = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let rootRouter = RootRouter()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //TEST
        if CommandLine.arguments.contains("isLoggined") {
            UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        }
        detectDebagDevice()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootRouter.chooseVC()//rootRouter.chooseVC()
        window?.makeKeyAndVisible()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    private func detectDebagDevice() {
        let DEBAGUUIDS = ["AE802D66-D16C-4DCD-B0FC-0A0657AA9F60", "5FDE2A8A-EB21-49A8-86B8-D56F72743021"]//user1man iphone]
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {return}
        print (uuid)
        if DEBAGUUIDS.contains(uuid) {
            IsDebagDevice = true
        }
        #if targetEnvironment(simulator)
            IsDebagDevice = true
        #endif
    }

}
extension AppDelegate {
static var shared: AppDelegate {
   return UIApplication.shared.delegate as! AppDelegate
}
}
