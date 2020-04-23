//
//  FriendsListVC.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 18.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// показ swiftui view окна друзей
class FriendsListVC: UIViewController {
    
    var child = UIHostingController(rootView: FriendsListView())

    override func viewDidLoad() {
        super.viewDidLoad()

        child.view.frame = self.view.bounds
        // First, add the view of the child to the view of the parent
        self.view.addSubview(child.view)
        // Then, add the child to the parent
        self.addChild(child)
    }
}
