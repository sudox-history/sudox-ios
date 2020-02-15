//
//  smsPhoneFormVC.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 13.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class smsPhoneFormVC: UIViewController {
    var telephone: String = ""
    var descriptionLabel = UILabel()
    var CodeTextField: SmsTextField = SmsTextField()
    let imageIcon = UIImageView(image: UIImage(systemName: "text.bubble"))
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addView()
        addDescriptionLabel()
        addImageIcon()
        addSmsCodeTextField()   
    }
    
    func addView () {
        self.title = SmsPhoneFormWelcomingTitle
    }
    
    func addImageIcon () {
        self.view.addSubview(imageIcon)
        //imageIcon.tintColor = .black
        imageIcon.easy.layout([Left(15).to(view.safeAreaLayoutGuide, .left),Right(16).to(descriptionLabel),Top(25).to(view.safeAreaLayoutGuide, .top),Height(24), Width(24)])
    }
    
    func addDescriptionLabel () {
        self.view.addSubview(descriptionLabel)
        descriptionLabel.text = smsPhoneFormDescription + " " + telephone
        descriptionLabel.easy.layout([Right(16),Top(15).to(view.safeAreaLayoutGuide, .top),Height(44)])
        descriptionLabel.setUpDescriptionLabel()
        descriptionLabel.isEnabled = false
        
    }
    
    func addSmsCodeTextField () {
        self.view.addSubview(CodeTextField)
        CodeTextField.configure()
        CodeTextField.easy.layout([Left(16),Right(16),Top(40).to(descriptionLabel), Height(50)])
        // данная часть кода срабатывает лишь когда вводится последняя цифра кода
        CodeTextField.didEnteredLastDigit = { [weak self] code in
            // вызов segue для след вида
            // если такой пользователь не зареган
//            self?.performSegue(withIdentifier: "SmsVerificationToNicknamePicker", sender: self)
            let vc = nicknamePickerVC()
            vc.modalPresentationStyle = .overFullScreen
            self?.show(vc, sender: nil)
            // иначе перекидывать сразу на экран ленты
            // ...
        }
        
    }
    
    @objc func rightNavBarItemTapped(){
        //self.performSegue(withIdentifier: "loginToSmsVerification", sender: self)
    }
}
