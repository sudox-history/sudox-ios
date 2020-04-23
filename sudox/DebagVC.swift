//
//  DebagVC.swift
//  Sudox-ios
//
//  Created by Иван Лобанов on 08/04/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
class DebagVC: UIViewController {
    
    var singOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSingOutButton()
        view.backgroundColor = .systemBackground
    }
    func addSingOutButton() {
        view.addSubview(singOutButton)
        singOutButton.easy.layout([Left(8).to(view.safeAreaLayoutGuide, .left),Right(8).to(view.safeAreaLayoutGuide, .right),Top(25).to(view.safeAreaLayoutGuide, .top),Height(44)])
        singOutButton.setTitle("Sing Out", for: .normal)
        singOutButton.backgroundColor = .systemBlue
        singOutButton.addTarget(self, action: #selector(singOut), for: .touchUpInside)
        
        
        
    }
    @objc func singOut() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        self.present(ViewController(), animated: true, completion: nil)
    }
}
