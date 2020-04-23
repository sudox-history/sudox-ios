//
//  MediaActivity.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

struct Media_activity: Decodable, Identifiable
{
    var id: Int
    var likes: Int = 0
    var dislikes: Int = 0
    var shares: Int = 0
    var comments: Int = 0
    
    var personal_activity: Int // liked - 1  disliked - 2  shared - 3
    
    init(_ id: Int, _ likes: Int, _ dislikes: Int, _ shares: Int, _ comments: Int, _ personal_activity: Int ) {
        self.id = id
        self.likes = likes
        self.dislikes = dislikes
        self.shares = shares
        self.comments = comments
        self.personal_activity = personal_activity
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case likes = "likes"
        case dislikes = "dislikes"
        case shares = "shares"
        case comments = "comments"
        case personal_activity = "personal_activity"
    }

}
