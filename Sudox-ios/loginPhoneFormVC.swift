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
import PhoneNumberKit

class loginPhoneFormVC: UIViewController {
    var descriptionLabel = UILabel()
    var phoneNumberTextField = PhoneNumberTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addView()
        addDescriptionLabel()
        addPhoneNumberTextField()
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
        
        descriptionLabel.text = loginPhoneFormdescription
     descriptionLabel.easy.layout([Left(16),Right(16),Top(16).to(view.safeAreaLayoutGuide, .top),Height(44)])
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = getColor().labelColor
        descriptionLabel.isEnabled = false
        
    }
    func addPhoneNumberTextField () {
        view.addSubview(phoneNumberTextField)
        
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.withPrefix = true
        self.phoneNumberTextField.withFlag = true
        self.phoneNumberTextField.withExamplePlaceholder = true
        self.phoneNumberTextField.easy.layout([Left(16),Right(16),Top(16).to(descriptionLabel), Height(44)])
        // закругление родительского view у поля ввода
        // добавление серых рамок
        
        self.phoneNumberTextField.layer.cornerRadius = 5
        self.phoneNumberTextField.clipsToBounds = true
        //PhoneNumberView.layer.borderColor = UIColor.init(red: 0.224, green: 0.224, blue: 0.224, alpha: 0.1).cgColor
        self.phoneNumberTextField.layer.borderWidth = 1.0

    }
    
    
    
    
}
