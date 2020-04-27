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
import Starscream
import SwiftKeychainWrapper

class loginPhoneFormVC: UIViewController {
    
    //socket
    //var socket: WebSocket!
    
    lazy var sk = Network.shared
    
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
        
        // подписываемся на делегат
        sk.websocket?.delegate = self
        
    }
    
    func addView() {
        self.view.backgroundColor = UIColor.systemBackground
        self.title = loginPhoneFormTitle
        
        self.navigationController?.view.tintColor = .globalGreen
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nextTitle, style: .plain, target: self, action: #selector(rightNavBarItemTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = getColor().labelColor
        
    }
    func addDescriptionLabel() {
        self.view.addSubview(descriptionLabel)
        descriptionLabel.text = loginPhoneFormDescription
        descriptionLabel.easy.layout([Right(16),Top(15).to(view.safeAreaLayoutGuide, .top),Height(44)])
        descriptionLabel.setUpDescriptionLabel()
        descriptionLabel.isEnabled = false
    }
    func addImageIcon() {
        self.view.addSubview(imageIcon)
        //imageIcon.tintColor = .black
        imageIcon.easy.layout([Left(16).to(view.safeAreaLayoutGuide, .left),Right(16).to(descriptionLabel),Top(25).to(view.safeAreaLayoutGuide, .top),Height(24), Width(24)])
        
    }
    func addPhoneNumberTextField() {
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
        
        self.phoneNumberTextField.withDefaultPickerUI = true
        
        // закругление родительского view у поля ввода
        // добавление серых рамок
        self.phoneNumberTextField.layer.cornerRadius = 5
        self.phoneNumberTextField.clipsToBounds = true
        self.phoneNumberTextField.layer.borderColor = UIColor.grayBorder.cgColor
        self.phoneNumberTextField.layer.borderWidth = 1.0
        self.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberCorrection), for: .editingChanged)
    }
    
    /// функция, срабатывающая при нажатии кнопки далее
    @objc func rightNavBarItemTapped() {
        
        // если телефон введен правильно
        if (phoneNumberTextField.isValidNumber)
        {
            let rawNumber = self.phoneNumberTextField.text!.filter { (char) -> Bool in return char.isNumber }
            
            sk.send("{\"method_name\": \"auth.create\",\"data\": {\"user_phone\": \"" + rawNumber + "\"}}")
            
            // если сервер ответил нам на наш телефон
            sk.websocket?.onEvent = { event in
                switch event {
                // handle events just like above...
                case .text(let string):
                    // читаем коды ответа и в случае положительного результата переходим на др экран
                    let data: [String: Any]  = string.convertToDictionary()!
                    self.performActionAfterEvent(data: data)
                    
                case .connected(_):
                    break
                case .disconnected(_, _):
                    break
                case .binary(_):
                    break
                case .pong(_):
                    break
                case .ping(_):
                    break
                case .error(_):
                    break
                case .viablityChanged(_):
                    break
                case .reconnectSuggested(_):
                    break
                case .cancelled:
                    break
                }
            }
        }
        else{ print("Error in telephone")}
    }
    
    @objc func performActionAfterEvent(data: [String: Any]) -> Void
    {
        switch (data["result"] as! Int )
        {
        case 0:
            print("OK code recieved (telephone send to server)")
            // есть ли такой пользователь по этому номеру телефона?
            let user_exists = (data["data"] as! [String: Any])["user_exists"] as! Bool

            // если сервер ответил, что такого пользователя не существует
            // открываем последующий экран регистрации (верификация телефона)
            if (!user_exists)
            {
                sk.SecWebSocketAccept = (data["data"] as! [String: Any])["auth_token"] as! String
                // записываем ключ сессии
                KeychainWrapper.standard.set(sk.SecWebSocketAccept,forKey: "registrationToken")
                print("ключ сессии записан в keychain")
                
                // вносим время записи, чтобы потом сверять, а не просрочился ли key
                KeychainWrapper.standard.set(NSDate.now as NSCoding,forKey: "registrationTokenExpiryDate")
                print("ключ сессии записан в keychain")
                
                let vc = smsPhoneFormVC()
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                //(smsPhoneFormVC(), sender: nil)
            }
        case 1:
            print("SERVICE_UNAVAILABLE recieved (telephone send to server)")
        case 3:
            print("REQUEST_FORMAT_INVALID recieved (telephone send to server)")
        case 104:
            print("AUTH_ALREADY_EXISTS recieved (telephone send to server)")
        case 108:
            print("USER_PHONE_BANNED recieved (telephone send to server)")
        default:
            print("unknown code recieved (telephone send to server)")
        }
    }
    
    // подкрашивание и активация кнопки 'next' в nav bar'e при корректном вводе телефона
    @objc func phoneNumberCorrection() {
        if (phoneNumberTextField.isValidNumber) {
            navigationItem.rightBarButtonItem?.tintColor = .globalGreen
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToSmsVerification" {
            let controller = segue.destination as! smsPhoneFormVC
            controller.telephone = phoneNumberTextField.text!
        }
    }
    
    public func RestoreSession()
    {
        // must check if there is any need to restore session
        //getting 'retrievedToken' - registration token
        if let retrievedToken: String = KeychainWrapper.standard.string(forKey: "registrationToken")
        {
            print("registrationToken найдено в базе")
            if let retrievedTokenDate: NSDate = KeychainWrapper.standard.object(forKey: "registrationTokenExpiryDate") as? NSDate
            {
                print("registrationTokenExpiryDate найдено в базе")
                let now =  NSDate.now as NSDate;
                
                if (now.isExpired(dateToCompare: (retrievedTokenDate), expirationTime: TimeInterval(5.0 * 60.0)))
                {
                    print("ключ expired. невозможно восстановить сессию")
                    // expired, should have deleted key from keychain
                    
                }
                else
                {
                    // not expired, can reactivate session
                    if (sk.restoreRegSession(retrievedToken))
                    {
                        print("READY TO LOAD VIEW AFTER RESTORATION")
                    }
                    else
                    {
                        print("restoration failed")
                    }
                }
            }
        }
    }
}

extension loginPhoneFormVC: WebSocketDelegate{
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
        switch event {
        case .connected(let headers):
            sk.isConnected = true
            print("websocket is connected: \(headers)")
            RestoreSession()
            
        case .disconnected(let reason, let code):
            sk.isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viablityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            sk.isConnected = false
        case .error(let error):
            sk.isConnected = false
            handleError(error)
            
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket[Login_PHONE_FORM] encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket[Login_PHONE_FORM] encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket[Login_PHONE_FORM] encountered an error")
        }
    }
}
