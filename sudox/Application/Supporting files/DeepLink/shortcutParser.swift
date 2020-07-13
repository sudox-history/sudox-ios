//
//  shortcutParser.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//


import Foundation
import UIKit

//возможные ключи шорткатов
enum ShortcutKey: String {
    case newListing = "com.sudox.newListing"
    case activity = "com.sudox.activity"
    case messages = "com.sudox.messages"
}

class ShortcutParser {
    static let shared = ShortcutParser()
    private init() { }
    
    //будет регистрировать шорткаты для различных типов пользователей.
    func registerShortcuts(for profileType: ProfileType) {
        let activityIcon = UIApplicationShortcutIcon(templateImageName: "Alert Icon")
        let activityShortcutItem = UIApplicationShortcutItem(type: ShortcutKey.activity.rawValue, localizedTitle: "Recent Activity", localizedSubtitle: nil, icon: activityIcon, userInfo: nil)
        
        let messageIcon = UIApplicationShortcutIcon(templateImageName: "Messenger Icon")
        let messageShortcutItem = UIApplicationShortcutItem(type: ShortcutKey.messages.rawValue, localizedTitle: "Messages", localizedSubtitle: nil, icon: messageIcon, userInfo: nil)
        
        
        //Создаём activityShortcutItem и messageShortcutItem для обоих типов профилей. Если текущий пользователь — хозяин (принимающая сторона), то добавляем newListingShortcutItem. Для каждого шортката мы используем UIApplicationShortcutIcon (эта иконка будет отображаться рядом с текстом соответствующего пункта меню быстрых действий при плавном надавливании на иконку приложения).
        UIApplication.shared.shortcutItems = [activityShortcutItem, messageShortcutItem]

        switch profileType {
        case .host:
            let newListingIcon = UIApplicationShortcutIcon(templateImageName: "New Listing Icon")
            let newListingShortcutItem = UIApplicationShortcutItem(type: ShortcutKey.newListing.rawValue, localizedTitle: "New Listing", localizedSubtitle: nil, icon: newListingIcon, userInfo: nil)
            UIApplication.shared.shortcutItems?.append(newListingShortcutItem)
        case .guest:
            break
        }
    }

    func handleShortcut(_ shortcut: UIApplicationShortcutItem) -> DeeplinkType? {
        switch shortcut.type {
        case ShortcutKey.activity.rawValue:
            return  .activity
        case ShortcutKey.messages.rawValue:
            return  .messages(.root)
        case ShortcutKey.newListing.rawValue:
            return .newListing
        default:
            return nil
        }
    }
}
