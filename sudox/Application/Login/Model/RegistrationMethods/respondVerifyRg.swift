//
//  respondVerify.swift
//  sudox
//
//  Created by Никита Казанцев on 27.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

/// Подтверждение или отклонение новой авторизации на другом неавторизированном устройстве пользователя
public struct respondVerifyMethod: Codable {
    var method_name: String = "auth.respondVerify"
    var data: respondVerifyData
}

struct respondVerifyData: Codable {
    var accept: Bool
    var public_key: String
    var auth_id: String
    var user_key_enc: String
}
