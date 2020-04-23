//
//  FriendFetcher.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 11.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

public class FriendFetcher: ObservableObject {
    @Published var friends = [whole_friend_json]()
    // @Published var onlyRequests = [Friend_request_list_item_json]()
    
    init(){
        preload()
        load()
    }
    
    // должен использоваться для загрузки кеша
    func preload()
    {
        
        friends = [whole_friend_json(id: 1, requests: [sudox.Friend_request_list_item_json(id: 1, person: sudox.Friend_list_item_json(id: 1, nickname: "isp13", online: ["online": "0", "last_seen": "last seen 14 minutes ago"], mutual: 32), text: "hello"), sudox.Friend_request_list_item_json(id: 2, person: sudox.Friend_list_item_json(id: 2, nickname: "kerJen", online: ["last_seen": "last seen now", "online": "1"], mutual: 2), text: ""), sudox.Friend_request_list_item_json(id: 3, person: sudox.Friend_list_item_json(id: 3, nickname: "kotlinovski", online: ["online": "0", "last_seen": "last seen 28 minutes ago"], mutual: 12), text: "is it even possible to comunicate with you")], maybeYouKnowCards: [sudox.Maybe_you_know_card_item_json(id: 1, person: sudox.Friend_list_item_json(id: 1, nickname: "isp13", online: ["online": "0", "last_seen": "last seen 14 minutes ago"], mutual: 28)), sudox.Maybe_you_know_card_item_json(id: 2, person: sudox.Friend_list_item_json(id: 2, nickname: "kerJen", online: ["online": "1", "last_seen": "last seen now"], mutual: 23)), sudox.Maybe_you_know_card_item_json(id: 3, person: sudox.Friend_list_item_json(id: 1, nickname: "kotlinovski", online: ["online": "0", "last_seen": "last seen 14 minutes ago"], mutual: 12))], friendList: [sudox.Friend_list_item_json(id: 1, nickname: "isp13", online: ["online": "0", "last_seen": "last seen 14 minutes ago"], mutual: 23), sudox.Friend_list_item_json(id: 2, nickname: "kerJen", online: ["last_seen": "last seen now", "online": "1"], mutual: 23), sudox.Friend_list_item_json(id: 3, nickname: "kotlinovski", online: ["online": "0", "last_seen": "last seen 14 minutes ago"], mutual: 23), sudox.Friend_list_item_json(id: 4, nickname: "sinapsis", online: ["online": "1", "last_seen": "last seen 14 minutes ago"], mutual: 23)])]
    }
    
    func load() {
        let url = URL(string: "https://gist.githubusercontent.com/isp13/4612effe4a92e86303f4e5087ee6941f/raw/c5b8686501910de9df200ae989b6666614f4f615/json%2520test")!
        print("LOADING")
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([whole_friend_json].self, from: d)
                    DispatchQueue.main.async {
                        self.friends = decodedLists
                        //self.onlyRequests = self.friends[0].requests
                        print("LOADED")
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print (error)
            }
            
        }.resume()
        
    }
    
    func sort(sortType: Int)
    {
        if sortType == 1{
            friends[0].friendList = friends[0].friendList.sorted(by: { $0.mutual > $1.mutual })
        }
        if sortType == 2{
            friends[0].friendList = friends[0].friendList.sorted(by: { $0.online["online"]! < $1.online["online"]! })
        }
        if sortType == 3{
            friends[0].friendList = friends[0].friendList.sorted(by: { $0.nickname > $1.nickname })
        }
    }
    
    func append(tmp: Friend_request_list_item_json)
    {
        friends[0].requests.append(tmp)
    }
    func append_rnd()
    {
        friends[0].requests.append(Friend_request_list_item_json(id: 0, person: Friend_list_item_json(id: 0, nickname: "isp13", online: ["online": "1", "last_seen": "now"], mutual: 23), text: "hello there"))
    }
    func delete(tmp: Int)
    {
        friends[0].requests.remove(at: tmp)
    }
    
    func deleteItems(at offsets: IndexSet) {
        friends[0].requests.remove(atOffsets: offsets)
    }
    
    func delete(obj: Friend_request_list_item_json)
    {
        var j = 0
        for i in friends[0].requests{
            
            if  i.id == obj.id{
                
                friends[0].requests.remove(at: j )
                break
            }
            j += 1
        }
    }
}
