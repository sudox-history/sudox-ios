//
//  feed_whole.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 23.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
struct whole_feed_json: Decodable, Identifiable
{
    var id: Int
    var stories: [Moment]
    var posts: [Post]
    
    init(_ id: Int, _ stories: [Moment], _ posts: [Post]) {
        self.id = id
        self.stories = stories
        self.posts = posts
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case stories = "stories"
        case posts = "posts"
    }
}
