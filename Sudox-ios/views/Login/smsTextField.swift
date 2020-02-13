//
//  smsTextField.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 13.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//
import UIKit

class SmsTextField: UITextField{
    
    // если будет введен последний символ, просигнализирует об этом
    var didEnteredLastDigit: ((String) -> Void)?
    
    var defaultCharacter = "-"
    
    private var isConfigured = false
    
    private var digitLabels = [UILabel]()
    
    
    // если объект принимает клик, то он становится firstResponder, т.е. клавиатура открывается
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure(with slotCount: Int = 5)
    {
        guard isConfigured == false else {return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // добавление распознавателя нажатий
        addGestureRecognizer(tapRecognizer)
    }
    
    private func configureTextField(){
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        
        // каждый раз при нажатии на клавишу происходит вызов ф-ции textDidChange
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView{
        
        let stackView = UIStackView()
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        // расстояние между квадратами
        stackView.spacing = 19.5
        
        // создаем в цикле столько квадратиков для ввода цифр кода из смс сколько нужно
        // прописываем им нужные свойства (дизайн и тп)
        for _ in 1 ... count {
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 15)
            
            label.backgroundColor = .clear
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            label.layer.borderColor = UIColor.grayBorder.cgColor
            label.layer.borderWidth = 1.0
            
            
            label.isUserInteractionEnabled = true
            
            stackView.addArrangedSubview(label)
            
            // если хотим изначально отображать подсказку в клетках ввода
            //label.text = defaultCharacter
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    @objc private func textDidChange(){
        
        // не дает вписывать больше нужного кол-ва цифр
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        
        // обновление label'ов, в которые вписываются новые символы
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy:  i)
                currentLabel.text = String(text[index])
            } else {
                //можно удалять символ при нажатии backspace
                currentLabel.text?.removeAll()
                
                // можно вписывать defaultCharacter
                //currentLabel.text? = defaultCharacter
            }
        }
        
        if text.count == digitLabels.count{
            didEnteredLastDigit?(text)
        }
    }
    
}

extension SmsTextField: UITextFieldDelegate{
    
    // не дает писать больше, чем есть слотов под input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        
        return characterCount < digitLabels.count ||  string == ""
    }
}
