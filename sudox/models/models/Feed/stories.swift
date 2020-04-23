//
//  stories.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 23.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

struct Moment: Decodable, Identifiable
{
    var id: Int
    
    var type: String
    
    var author: person_json
    
    var date: String
    
    var was_viewed: Bool
    
    var containment: String
    
    init(_ id: Int, _ type: String, _ author: person_json, _ date: String, _ was_viewed: Bool, _ containment: String ) {
        self.id = id
        self.type = type
        self.author = author
        self.date = date
        self.was_viewed = was_viewed
        self.containment = containment
    }
}
