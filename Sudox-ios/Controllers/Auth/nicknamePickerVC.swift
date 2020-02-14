//
//  nicknamePickerVC.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 14.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class nicknamePickerVC: UIViewController {
    var descriptionLabel = UILabel()
    var nicknameTextField = UITextField()
    let imageIcon = UIImageView(image: UIImage(systemName: "person.crop.circle"))
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addDescriptionLabel()
        addImageIcon()
        addNicknameTextField()
        
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
        descriptionLabel.text = nicknamePickerDescription
        descriptionLabel.easy.layout([Right(16),Top(15).to(view.safeAreaLayoutGuide, .top),Height(44)])
        descriptionLabel.setUpDescriptionLabel()
        descriptionLabel.isEnabled = false
        
    }
    func addImageIcon () {
        self.view.addSubview(imageIcon)
        //imageIcon.tintColor = .black
        imageIcon.easy.layout([Left(15).to(view.safeAreaLayoutGuide, .left),Right(16).to(descriptionLabel),Top(25).to(view.safeAreaLayoutGuide, .top),Height(24), Width(24)])
        
    }
    func addNicknameTextField () {
        view.addSubview(nicknameTextField)
        
        self.nicknameTextField.becomeFirstResponder()

        self.nicknameTextField.easy.layout([Left(16),Right(16),Top(40).to(descriptionLabel), Height(50)])
        
        self.nicknameTextField.textContentType = .nickname
        self.nicknameTextField.autocorrectionType = .yes
        // закругление родительского view у поля ввода
        // добавление серых рамок
        self.nicknameTextField.layer.cornerRadius = 5
        self.nicknameTextField.clipsToBounds = true
        self.nicknameTextField.layer.borderColor = UIColor.grayBorder.cgColor
        self.nicknameTextField.layer.borderWidth = 1.0

        self.nicknameTextField.addTarget(self, action: #selector(CheckAvailability), for: .editingDidEnd)
    }

    @objc func rightNavBarItemTapped(){
        //self.performSegue(withIdentifier: "loginToSmsVerification", sender: self)
    }

    @objc func CheckAvailability(){
        //
    }
}
