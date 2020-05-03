//
//  messagesListStruct.swift
//  sudox
//
//  Created by Иван Лобанов on 26/04/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
struct messagesListStruct {
    let name: String
    let id: String
    let lastMessage: String
    let timeOfLastMessage: Date
    let isOnline: Bool
    var numberOfUnread: Int
    var isMuted: Bool
}
