//
//  peopleNavController.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 12/03/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit

class PeopleNavController: UINavigationController {
    var segmentControl : UISegmentedControl!
    override func viewDidLoad() {
            
            //let navBarAppearance = UINavigationBarAppearance()
            self.navigationItem.titleView = segmentControl
        
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            navBarAppearance.backgroundColor = UIColor.tertiarySystemBackground
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.popToRootViewController(animated: true)

        }
}
