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
import Starscream
class smsPhoneFormVC: UIViewController {
    var telephone: String = ""
    var descriptionLabel = UILabel()
    var CodeTextField: SmsTextField = SmsTextField()
    let imageIcon = UIImageView(image: UIImage(systemName: "text.bubble"))
    
    // объект глобального сокета
    lazy var sk = Network.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addView()
        addDescriptionLabel()
        addImageIcon()
        addSmsCodeTextField()
        
        // подписываемся уже на новый делегат
        sk.websocket?.delegate = self 
    }
    
    func addView () {
        self.title = SmsPhoneFormWelcomingTitle
        view.backgroundColor = .systemBackground
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
        
        CodeTextField.textContentType = .oneTimeCode
        // данная часть кода срабатывает лишь когда вводится последняя цифра кода
        CodeTextField.didEnteredLastDigit = { [weak self] code in
            
            self!.sk.send("{\"method_name\": \"auth.checkCode\",\"data\": {\"auth_code\": " + (self!.CodeTextField.fullStr) + "}}")
            
            // если сервер ответил нам на наш код СМС
            self!.sk.websocket?.onEvent = { event in
                switch event {
                // handle events just like above...
                case .text(let string):
                    // читаем коды ответа и в случае положительного результата переходим на др экран
                    let data: [String: Any]  = string.convertToDictionary()!
                    self!.performActionAfterEvent(data: data)
                    
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
    }
    
    @objc func performActionAfterEvent(data: [String:Any]) -> Void{

        switch (data["result"] as! Int )
        {
        case 0:
            print("OK code recieved (code send to server)")
            
            let vc = nicknamePickerVC()
            vc.modalPresentationStyle = .overFullScreen
            self.show(vc, sender: nil)
            
        case 1:
            print("SERVICE_UNAVAILABLE recieved (telephone send to server)")
        case 3:
            print("REQUEST_FORMAT_INVALID recieved (telephone send to server)")
        case 102:
            print("AUTH_SESSION_NO_LONGER_VALID recieved (telephone send to server)")
        case 106:
            print("AUTH_CODE_INVALID recieved (telephone send to server)")
            let alert = UIAlertController(title: "Invalid code", message: "Verification code is invalid or has expired. Try again", preferredStyle: .alert)
            
            present(alert, animated: true, completion:{
               alert.view.superview?.isUserInteractionEnabled = true
               alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
            })
        default:
            print("unknown code recieved (telephone send to server)")
        }
    }
    
    @objc func rightNavBarItemTapped(){
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
}


extension smsPhoneFormVC: WebSocketDelegate{
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
        switch event {
        case .connected(let headers):
            
            print("websocket3 is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket3 is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received3 text: \(string)")
        case .binary(let data):
            print("Received3 data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viablityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        case .error(let error):
            
            handleError(error)
            
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket[SMS_PHONE_FORM] encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket[SMS_PHONE_FORM] encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket[SMS_PHONE_FORM] encountered an error")
        }
    }
}
