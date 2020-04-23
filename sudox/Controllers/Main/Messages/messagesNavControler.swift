//
//  messagesNavControler.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 12/03/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit

class messagesNavControler: UINavigationController {
    var segmentControl : UISegmentedControl!
    override func viewDidLoad() {
        
        //let navBarAppearance = UINavigationBarAppearance()
        self.navigationItem.titleView = segmentControl
        setupSegmentControl()
    }
    func setupSegmentControl() {
        //segmentControl.insertSegment(withTitle: "Hello", at: 2, animated: true)
//        segmentControl.backgroundColor=UIColor.systemBlue
    }
}
