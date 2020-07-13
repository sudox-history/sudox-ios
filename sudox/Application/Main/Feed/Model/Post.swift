//
//  Post.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
import UIKit

// класс описывающий объект пост
struct Post: Decodable, Identifiable
{
    var id: Int
    
    var author: person_json
    
    var date: String
    
    var post_string: String
    
    var post_media: [String]
    
    var social_activity: Media_activity
    
    init(_ id: Int, _ author: person_json, _ date: String,  _ post_string: String,_ post_media: [String], _ social_activity: Media_activity ) {
        self.id = id
        self.author = author
        self.date = date
        self.post_string = post_string
        self.social_activity = social_activity
        self.post_media = post_media
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case date = "date"
        case post_string = "post_string"
        case post_media = "post_media"
        case social_activity = "social_activity"
    }
}
