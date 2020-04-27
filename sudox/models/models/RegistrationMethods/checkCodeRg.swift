//
//  checkCode.swift
//  sudox
//
//  Created by Никита Казанцев on 27.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

/// Проверка кода, введенного пользователем
public struct checkCodeMethod: Codable {
    var method_name: String = "auth.checkCode"
    var data: checkCodeData
}

struct checkCodeData: Codable {
    var auth_id: String
    var auth_code: Int
}
