//
//  deeplinkParser.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation


class DeeplinkParser {
    static let shared = DeeplinkParser()
    private init() { }
    
    //метод, который принимает URL и возвращает опциональный DeeplinkType
    func parseDeepLink(_ url: URL) -> DeeplinkType? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return nil
        }
        
        var pathComponents = components.path.components(separatedBy: "/")

        // the first component is empty
        pathComponents.removeFirst()
        
        switch host {
        case "messages":
            if let messageId = pathComponents.first {
                return DeeplinkType.messages(.details(id: messageId))
            }
        case "request":
            if let requestId = pathComponents.first {
                return DeeplinkType.request(id: requestId)
            }
        default:
            break
        }
        return nil
    }
}
