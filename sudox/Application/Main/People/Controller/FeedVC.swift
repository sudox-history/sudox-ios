//
//  FeedVC.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// отображение свифтюай ленты
class FeedtVC: UIViewController {
    
    var child = UIHostingController(rootView: Feed())

    override func viewDidLoad() {
        super.viewDidLoad()

        //child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = self.view.bounds
        // First, add the view of the child to the view of the parent
        self.view.addSubview(child.view)
        // Then, add the child to the parent
        self.addChild(child)
    }
}
