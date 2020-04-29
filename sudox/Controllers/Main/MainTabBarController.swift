//
//  MainTabBarController.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 22.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    @objc func openDebag() {
        self.present(DebagVC(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyboard.instantiateViewController(withIdentifier: "loginNavController")
//        newViewController.modalPresentationStyle = .overFullScreen
        var navigationController1: PeopleNavController?
        var navigationController2: messagesNavControler?
        
        
        let first_icon = UIImage(systemName: "person.2",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        let second_icon = UIImage(systemName: "message",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        //let third_icon = UIImage(systemName: "globe",
        //withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .medium))?.withTintColor(.globalGreen)
        
        let fourth_icon = UIImage(systemName: "person.crop.circle",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        let debagIcon = UIImage(systemName: "gear",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        navigationController1 = PeopleNavController(rootViewController: PeopleViewController(transitionStyle: .scroll, navigationOrientation: .horizontal))
        navigationController2 = messagesNavControler(rootViewController: MessagesViewController())
        
        
        
        ///
        /// строчка 43 ломает ломает все констреинты в swiftui view. временно заменил на строчку 44
        let firstViewController = navigationController1
        //let firstViewController = PeopleViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)// контроллер1
                
        firstViewController?.tabBarItem = UITabBarItem(title: "People", image: first_icon, tag: 0)
        ///
        
        let secondViewController = navigationController2 // контроллер 2
        //let secondViewController = MessagesViewController() // контроллер 2
        secondViewController?.tabBarItem = UITabBarItem(title: "Messages", image: second_icon, tag: 1)
        
//        let thirdViewController = WorldViewController() // контроллер 3
//        thirdViewController.tabBarItem = UITabBarItem(title: "World", image: third_icon, tag: 2)
        
    
        
        let fourthViewController = BlogViewController() // контроллер 4
        fourthViewController.tabBarItem = UITabBarItem(title: "Blog", image: fourth_icon, tag: 3)
        
        let debagViewController = DebagVC()
        debagViewController.tabBarItem = UITabBarItem(title: "Debag", image: debagIcon, tag: 4)
        
        var tabBarList = [firstViewController, secondViewController, fourthViewController] //thirdViewController, secondViewController
        if IsDebagDevice {tabBarList.append(debagViewController)}

        self.tabBar.tintColor = .globalGreen
        
        viewControllers = tabBarList as? [UIViewController]
        // Do any additional setup after loading the view.
        
        let navBarAppearance = UITabBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()

        navBarAppearance.backgroundColor = UIColor.tertiarySystemBackground
        tabBar.standardAppearance = navBarAppearance
        //tabBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.popToRootViewController(animated: true)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
