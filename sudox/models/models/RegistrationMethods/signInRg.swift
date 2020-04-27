//
//  signIn.swift
//  sudox
//
//  Created by Никита Казанцев on 27.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

/// Авторизация пользователя
public struct signInMethod: Codable {
    var method_name: String = "auth.respondVerify"
    var data: signInData
}

struct signInData: Codable {
    var auth_id: String
    var user_key_hash: String
}
