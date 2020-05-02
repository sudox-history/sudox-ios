//
//  MessagesPageController.swift
//  sudox
//
//  Created by Иван Лобанов on 02/05/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

//
//  PeopleViewController.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 11.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import MaterialDesignWidgets
// класс для свайпа окон (новостей и вкладки друзей) в page view. тут механика смены видов
class MessagesPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [MessagesViewController(),
                TalksListViewController()]
    }()
    var segmantControl = MaterialSegmentedControl(selectorStyle: .line, textColor: .label, selectorTextColor: .label, selectorColor: colors.currentColors.mainColor, bgColor: .clear)//UISegmentedControl()//
    func addSegmentButtons(names: [String]) -> [UIButton]{
        var buttons: [UIButton]? = []
        for buttonName in names {
            var button = UIButton()
            button.setTitle(buttonName)
            
            buttons?.append(button)
        }
        
        return buttons!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        
        
        /*
         let viewWidth = self.view.frame.size.width
         let headerView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 75))
         let descLabel = UIButton(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 40))
         
         headerView.backgroundColor = UIColor(named: "WhiteBlack")
         headerView.addSubview(descLabel)
         
         self.view.addSubview(headerView)
         */
        addSegmentControll()
        
    }
    
    
    func addSegmentControll () {
        
        segmantControl.tintColor = .globalGreen
        //segmantControl.selectedSegmentTintColor = .globalGreen
        //segmantControl.insertSegment(withTitle: "Yours", at: 0, animated: true) //будет после MVP
        segmantControl.segments = addSegmentButtons(names: ["Chats", "Talks"])
//        segmantControl.insertSegment(withTitle: "Activity", at: 0, animated: true)
//        segmantControl.insertSegment(withTitle: "People", at: 1, animated: true)
        segmantControl.backgroundColor = UIColor.systemBackground
        segmantControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmantControl
        segmantControl.addTarget(self, action: #selector(changeScreen), for: .valueChanged)
        segmantControl.backgroundColor = navigationController?.navigationBar.backgroundColor
        navigationController?.hidesBarsOnSwipe=true
        
        
    }
    @objc func changeScreen (sender:MaterialSegmentedControl) {
        
        self.setViewControllers([self.orderedViewControllers[sender.selectedSegmentIndex]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        segmantControl.selectedSegmentIndex = 0
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        segmantControl.selectedSegmentIndex = 1
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
    
    
    
    
}
