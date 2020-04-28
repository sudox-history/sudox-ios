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
import MessagePacker

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
            
            let dict = checkCodeMethod(method_name: "auth.checkCode", data: checkCodeData(auth_id: self!.sk.auth_id, auth_code: Int(self!.CodeTextField.fullStr) ?? 0 ))
            
            
            let data = try! MessagePackEncoder().encode(dict)
            
            // отправляем код смс на сервер
            self!.sk.send(data)

        }
    }
    
    func performActionAfterSuccessEvent(data: checkCodeAnswer) -> Void {
        
            let vc = nicknamePickerVC()
            vc.modalPresentationStyle = .overFullScreen
            self.show(vc, sender: nil)

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
            print("Received SMSFORM data: \([UInt8](data))")
            do {
                let decoded = try MessagePackDecoder().decode(checkCodeAnswer.self, from: data)
                print(decoded)
                
                switch decoded.method_result {
                case 0: // OK
                    performActionAfterSuccessEvent(data: decoded)
                    break
                case 1: // SERVICE_UNAVAILABLE
                    handleCheckCodeMethodError(1, message: "SERVICE_UNAVAILABLE")
                    break
                case 2: // ACCESS_DENIED
                    handleCheckCodeMethodError(2, message: "ACCESS_DENIED")
                    break
                case 3: // FORMAT_INVALID
                    handleCheckCodeMethodError(3, message: "FORMAT_INVALID")
                    break
                case 101: // AUTH_NOT_FOUND
                    handleCheckCodeMethodError(101, message: "AUTH_NOT_FOUND")
                    break
                case 103: // AUTH_DROPPED
                    handleCheckCodeMethodError(103, message: "AUTH_DROPPED")
                    break
                case 105: // AUTH_CODE_INVALID
                    handleCheckCodeMethodError(103, message: "AUTH_CODE_INVALID")
                    break
                default: // UNEXPECTED ERROR
                    handleCheckCodeMethodError(-1, message: "UNEXPECTED_ERROR")
                    break
                }
            }
            catch {}
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
    
    func handleCheckCodeMethodError(_ error: Int, message: String)
    {
        
        let alert = UIAlertController(title: "Error: " + String(error), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion:{
           alert.view.superview?.isUserInteractionEnabled = true
           alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }

}
