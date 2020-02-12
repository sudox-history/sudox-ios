//
//  loginPhoneFormVC.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 12/02/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class loginPhoneFormVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        
    }
    func addView () {
        self.view.backgroundColor = UIColor.systemBackground
        self.title = loginPhoneFormTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    
}
