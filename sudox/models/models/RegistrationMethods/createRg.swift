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

struct createAnswer: Codable
{
    var method_name: String = "auth.create"
    var method_result: Int
    var data: createDataAnswer? = nil
}

struct createDataAnswer: Codable {
    var auth_id: String
    var user_exists: Bool
}
