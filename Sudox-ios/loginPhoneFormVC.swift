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
    var descriptionLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addDescriptionLabel()
    }
    func addView () {
        self.view.backgroundColor = UIColor.systemBackground
        self.title = loginPhoneFormTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nextTitle, style: .plain, target: self, action: #selector(rightNavBarItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = getColor().labelColor
    }
    @objc func rightNavBarItemTapped(){
        
    }
    func addDescriptionLabel() {
        
        self.view.addSubview(descriptionLabel)
        
        descriptionLabel.text = ""
     descriptionLabel.easy.layout([Left(16),Right(16),Top(16).to(view.safeAreaLayoutGuide, .top),Height(44)])
        
        descriptionLabel.textColor = getColor().labelColor
        
    }
    
}
