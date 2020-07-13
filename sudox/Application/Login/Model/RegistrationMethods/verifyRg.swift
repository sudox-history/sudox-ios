//
//  verify.swift
//  sudox
//
//  Created by Никита Казанцев on 27.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

/// Отправка подтверждения авторизации на другой авторизированный телефон пользователя
public struct verifyMethod: Codable {
    var method_name: String = "auth.verify"
    var data: verifyData
}

struct verifyData: Codable {
    var auth_id: String
    var public_key: String
}
