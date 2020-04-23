//
//  person.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 15.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
struct Person: Identifiable
{
    var id: Int
    var nickname: String
    var online: [String: Any]
    var mutual: Int
    
    init( _ id: Int, _ nickname: String, _ online: [String: Any], _ mutual: Int) {
        self.id = id
        self.nickname = nickname
        self.online = online
        self.mutual = mutual
    }
}

struct person_json: Decodable, Identifiable {
    public var id: Int
    public var nickname: String
    public var online: [String: String]
    public var mutual: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nickname = "nickname"
        case online = "online"
        case mutual = "mutual"
        }
}

enum ProfileType: String {
    case guest = "Guest" // default
    case host = "Host"
}


struct whole_friend_json: Decodable, Identifiable {
    public var id: Int
    public var requests: [Friend_request_list_item_json]
    public var maybeYouKnowCards: [Maybe_you_know_card_item_json]
    public var friendList: [Friend_list_item_json]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case requests = "requests"
        case maybeYouKnowCards = "maybeYouKnowCards"
        case friendList = "friendList"
        }
}


struct Friend_list_item_json: Decodable, Identifiable {
    public var id: Int
    public var nickname: String
    public var online: [String: String]
    public var mutual: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nickname = "nickname"
        case online = "online"
        case mutual = "mutual"
        }
}
struct Friend_request_list_item_json: Decodable, Identifiable {
    public var id: Int
    public var person: Friend_list_item_json
    public var text: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case person = "person"
        case text = "text"
        }
}
struct Maybe_you_know_card_item_json: Decodable, Identifiable {
    public var id: Int
    public var person: Friend_list_item_json
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case person = "person"
        }
}

func requestsJsonToRequestsList(tmp: [Friend_request_list_item_json]) -> [friendRequest]{
       var newlst = [friendRequest]()
       
       for i in tmp{
           newlst.append( friendRequest(id: i.id, nickname: i.person.nickname, online: i.person.online, mutual: i.person.mutual, requestText: i.text))
       }
       
       return newlst
       
   }
