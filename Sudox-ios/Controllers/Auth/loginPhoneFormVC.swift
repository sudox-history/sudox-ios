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
    let imageIcon = UIImageView(image: UIImage(systemName: "phone"))
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addView()
        addDescriptionLabel()
        addImageIcon()
        addPhoneNumberTextField()
    }
    func addView () {
        self.view.backgroundColor = UIColor.systemBackground
        self.title = loginPhoneFormTitle
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nextTitle, style: .plain, target: self, action: #selector(rightNavBarItemTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = getColor().labelColor
        
    }
    func addDescriptionLabel () {
        
        self.view.addSubview(descriptionLabel)
        descriptionLabel.text = loginPhoneFormdescription
        descriptionLabel.easy.layout([Right(16),Top(15).to(view.safeAreaLayoutGuide, .top),Height(44)])
        descriptionLabel.setUpDescriptionLabel()
        descriptionLabel.isEnabled = false
        
    }
    func addImageIcon () {
        self.view.addSubview(imageIcon)
        imageIcon.tintColor = .black
        imageIcon.easy.layout([Left(15).to(view.safeAreaLayoutGuide, .left),Right(16).to(descriptionLabel),Top(25).to(view.safeAreaLayoutGuide, .top),Height(24), Width(24)])
        
    }
    func addPhoneNumberTextField () {
        view.addSubview(phoneNumberTextField)
        
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.withPrefix = true
        self.phoneNumberTextField.withFlag = true
        self.phoneNumberTextField.withExamplePlaceholder = true
        self.phoneNumberTextField.easy.layout([Left(16),Right(16),Top(40).to(descriptionLabel), Height(50)])
        // регулирование расстояние кнопки с регионом от края
        self.phoneNumberTextField.flagButton.contentEdgeInsets.left = 20
        // макс длина номера
        self.phoneNumberTextField.maxDigits = 15
        // phone auto-fill
        self.phoneNumberTextField.textContentType = .telephoneNumber
        self.phoneNumberTextField.autocorrectionType = .yes
        // закругление родительского view у поля ввода
        // добавление серых рамок
        self.phoneNumberTextField.layer.cornerRadius = 5
        self.phoneNumberTextField.clipsToBounds = true
        self.phoneNumberTextField.layer.borderColor = UIColor.grayBorder.cgColor
        self.phoneNumberTextField.layer.borderWidth = 1.0

        self.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberCorrection), for: .editingChanged)
    }
    
    
    @objc func rightNavBarItemTapped(){
        self.performSegue(withIdentifier: "loginToSmsVerification", sender: self)
        
    }
    @objc func phoneNumberCorrection(){
        if (phoneNumberTextField.isValidNumber) {
            navigationItem.rightBarButtonItem?.tintColor = .green
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
}
