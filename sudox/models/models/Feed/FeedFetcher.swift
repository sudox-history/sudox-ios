//
//  FeedFetcher.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 23.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation
//
//  FriendFetcher.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 11.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import Foundation

public class FeedFetcher: ObservableObject {
    @Published var feed = [whole_feed_json]()
    // @Published var onlyRequests = [Friend_request_list_item_json]()
    
    init(){
        preload()
        load()
    }
    
    // должен использоваться для загрузки кеша
    func preload()
    {
        feed = [whole_feed_json(1,
                                [Moment(1, "closeFriend", person_json(id: 1, nickname: "loh", online: ["online": "0", "last_seen": "now"], mutual: 32), "23.03.2020 -11:34", true, "breakingbad")],
                                [Post(1, person_json(id: 1, nickname: "isp13", online: ["online": "0", "last_seen": "now"], mutual: 32), "23.03.2020 11:34", "hello", ["breakingbad"], Media_activity(2,41, 2, 7, 3, 1) )
            ]
            )
        ]
    }
    
    func load() {
        let url = URL(string: "https://gist.githubusercontent.com/isp13/bf54a53d2e0bb5dcb15196606d52a8ad/raw/6d733cd15c5d20b227635faa099be4cce12faa99/gistfile1.txt")!
        print("LOADING")
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([whole_feed_json].self, from: d)
                    DispatchQueue.main.async {
                        self.feed = decodedLists
                        //self.onlyRequests = self.friends[0].requests
                        print("\n")
                        print(self.feed)
                        print("\n")
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
            feed[0].stories = feed[0].stories.sorted(by: { $0.author.nickname > $1.author.nickname })
        }
        if sortType == 2{
            feed[0].stories = feed[0].stories.sorted(by: { $0.author.online["online"]! > $1.author.online["online"]! })
        }
        if sortType == 3{
            feed[0].stories = feed[0].stories.sorted(by: { $0.type > $1.type })
        }
    }
    
    func append_rnd()
    {
        feed[0].stories.append(Moment(1, "closeFriend", person_json(id: 1, nickname: "loh", online: ["online": "0", "last_seen": "now"], mutual: 32), "23.03.2020 -11:34", true, "breakingbad"))
    }
}
