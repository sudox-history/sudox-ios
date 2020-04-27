//
//  signUp.swift
//  sudox
//
//  Created by Никита Казанцев on 27.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

/// Регистрация пользователя
public struct signUpMethod: Codable {
    var method_name: String = "auth.signUp"
    var data: signUpData
}

struct signUpData: Codable {
    var auth_id: String
    var user_name: String
    var user_nickname: String
    var user_key_hash: String
}
