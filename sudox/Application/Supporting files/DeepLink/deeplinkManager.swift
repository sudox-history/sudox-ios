//
//  deeplink.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit

enum DeeplinkType {
    enum Messages {
        case root
        case details(id: String)
    }
    case messages(Messages)
    case activity
    case newListing
    case request(id: String)
}

let Deeplinker = DeepLinkManager()

class DeepLinkManager {
   fileprivate init() {}
   private var deeplinkType: DeeplinkType?
    
   // check existing deepling and perform action
    
   func checkDeepLink() {
    
        guard let deeplinkType = deeplinkType else {
            return
         }
       
        DeeplinkNavigator.shared.proceedToDeeplink(deeplinkType)
         // reset deeplink after handling
         self.deeplinkType = nil // (1)
    }
    
    
    //Этот метод вначале попытается получить из шорткат-элемента DeeplinkType, и затем вернёт булево значение, обозначающее, удалась ли эта операция. При этом метод сохранит полученный из шортката тип в переменную deeplinkType.
    //@discardableResult говорит компилятору игнорировать неиспользуемое получаемое в методе значение, благодаря чему мы не получаем предупреждение “unused result”
    @discardableResult
    func handleShortcut(item: UIApplicationShortcutItem) -> Bool {
        deeplinkType = ShortcutParser.shared.handleShortcut(item)
        return deeplinkType != nil
    }
    
    @discardableResult
    func handleDeeplink(url: URL) -> Bool {
       deeplinkType = DeeplinkParser.shared.parseDeepLink(url)
       return deeplinkType != nil
    }
}
