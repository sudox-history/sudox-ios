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

        var navigationController1: PeopleNavController?
        var navigationController2: messagesNavControler?
        var navigationController3: blogNavController?
        
        let first_icon = UIImage(systemName: "person.2",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        let second_icon = UIImage(systemName: "message",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)

        let third_icon = UIImage(systemName: "person.crop.circle",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        let debagIcon = UIImage(systemName: "gear",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withTintColor(.globalGreen)
        
        
        navigationController1 = PeopleNavController(rootViewController: PeopleViewController(transitionStyle: .scroll, navigationOrientation: .horizontal))
        navigationController2 = messagesNavControler(rootViewController: MessagesPageController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil))
        navigationController3 = blogNavController(rootViewController: BlogViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil))
        
        
        let firstViewController = navigationController1
        firstViewController?.tabBarItem = UITabBarItem(title: "People", image: first_icon, tag: 0)

        
        let secondViewController = navigationController2
        secondViewController?.tabBarItem = UITabBarItem(title: "Messages", image: second_icon, tag: 1)

        
        let thirdViewController = navigationController3 // контроллер 4
        thirdViewController?.tabBarItem = UITabBarItem(title: "Blog", image: third_icon, tag: 3)
        
        let debagViewController = DebagVC()
        debagViewController.tabBarItem = UITabBarItem(title: "Debag", image: debagIcon, tag: 4)
        
        var tabBarList: [UIViewController?] = [firstViewController, secondViewController, thirdViewController]
        
        if IsDebagDevice {tabBarList.append(debagViewController)}

        viewControllers = tabBarList as? [UIViewController]

        
        let navBarAppearance = UITabBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()

        navBarAppearance.backgroundColor = UIColor.tertiarySystemBackground
        self.tabBar.tintColor = .globalGreen
        tabBar.standardAppearance = navBarAppearance

        self.navigationController?.popToRootViewController(animated: true)

    }
}
