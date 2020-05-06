//
//  BlogViewController.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 11.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import MaterialDesignWidgets

class BlogViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [BlogFeedController(),
        BlogBotsController()]
    }()
    
    var segmantControl = MaterialSegmentedControl(selectorStyle: .line, textColor: .label, selectorTextColor: .label, selectorColor: colors.currentColors.mainColor, bgColor: .clear)//UISegmentedControl()//
    
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

        addSegmentControll()
    }
    
    func addSegmentButtons(names: [String]) -> [UIButton]{
        var buttons: [UIButton]? = []
        for buttonName in names {
            let button = UIButton()
            button.setTitle(buttonName)
            
            buttons?.append(button)
        }
        
        return buttons!
    }
    
    
    func addSegmentControll () {
        
        segmantControl.tintColor = .globalGreen
        segmantControl.segments = addSegmentButtons(names: ["Feed", "Bots"])

        segmantControl.backgroundColor = UIColor.systemBackground
        segmantControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmantControl
        segmantControl.addTarget(self, action: #selector(changeScreen), for: .valueChanged)
        segmantControl.backgroundColor = navigationController?.navigationBar.backgroundColor
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    @objc func changeScreen (sender:MaterialSegmentedControl) {
        print(1)
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
