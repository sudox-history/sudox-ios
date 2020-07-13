//
//  errorModel.swift
//  sudox
//
//  Created by Никита Казанцев on 03.05.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//
//https://stackoverflow.com/questions/40671991/generate-your-own-error-code-in-swift-3

import Foundation


enum AppError {
    case authorization(type: Enums.AuthorizationError)

    class Enums { }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .authorization(let type): return type.localizedDescription
        }
    }
}
// MARK: - Authorization Errors

extension AppError.Enums {
    enum AuthorizationError: Int {
        case SERVICE_UNAVAILABLE = 001
        case ACCESS_DENIED = 002
        case FORMAT_INVALID = 003
        case AUTH_NOT_FOUND = 101
        case AUTH_EXISTS = 102
        case AUTH_DROPPED = 103
        case AUTH_TYPE_INVALID = 104
        case AUTH_CODE_INVALID = 105
        case AUTH_CODE_SENT = 106
        case USER_PHONE_BANNED = 107
        case USER_KEY_HASH_INVALID = 108
    }
}

extension AppError.Enums.AuthorizationError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .SERVICE_UNAVAILABLE: return "сервис недоступен"
            case .ACCESS_DENIED: return "доступ запрещен"
            case .FORMAT_INVALID: return "неверный формат данных"
            case .AUTH_NOT_FOUND: return "авторизация не найдена"
            case .AUTH_EXISTS: return "авторизация существует"
            case .AUTH_DROPPED: return "истек срок жизни авторизации"
            case .AUTH_TYPE_INVALID: return "невозможно выполнить метод на этом типе авторизации"
            case .AUTH_CODE_INVALID: return "неправильный проверочный код"
            case .AUTH_CODE_SENT: return "код был отправлен"
            case .USER_PHONE_BANNED: return "телефон пользователя забанен"
            case .USER_KEY_HASH_INVALID: return "неверный хэш пользовательского ключа"
        }
    }

    var errorCode: Int? {
        switch self {
            case .SERVICE_UNAVAILABLE: return 001
            case .ACCESS_DENIED: return 002
            case .FORMAT_INVALID: return 003
            case .AUTH_NOT_FOUND: return 0101
            case .AUTH_EXISTS: return 0102
            case .AUTH_DROPPED: return 0103
            case .AUTH_TYPE_INVALID: return 0104
            case .AUTH_CODE_INVALID: return 0105
            case .AUTH_CODE_SENT: return 0106
            case .USER_PHONE_BANNED: return 0107
            case .USER_KEY_HASH_INVALID: return 0108
        }
    }
}


