//
//  RegistrationStructs.swift
//  sudox
//
//  Created by Никита Казанцев on 27.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

/// Создание сессии авторизации
public struct createMethod: Codable {
    var method_name: String = "auth.create"
    var data: createData
}

struct createData: Codable {
    var user_phone: String
}
