//
//  Feed.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI

// структура выводящая весь feed экран. тут и истории, тут и посты
struct Feed: View {
    
    @ObservedObject var fetcher = FeedFetcher()
    var body: some View {
        

            ScrollView(.vertical, showsIndicators: false){
                
                HStack {
                    Text("Moments").bold().padding(.leading, 16)
                    Spacer()
                }.padding(.top, 16)
                .contextMenu{
                    Button("nickname sort") {self.fetcher.sort(sortType: 1)}
                    Button("online sort") {self.fetcher.sort(sortType: 2)}
                    Button("type sort") {self.fetcher.sort(sortType: 3)}
                    Button("Add new") {self.fetcher.append_rnd()}
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 16) {
                        ForEach(fetcher.feed[0].stories) { story in
                                Moments_item(person: Person(story.id, story.author.nickname, story.author.online , story.author.mutual), was_viewed: story.was_viewed, containment: story.containment)
                            }
                        Spacer()
                        
                    }.padding(.leading,16)
                    
                    
                }.frame(height: 80).edgesIgnoringSafeArea(.horizontal)
                
                
                
                
                HStack {
                    Text("News").bold()
                    Spacer()
                }.padding(.leading).padding(.top, 16)
                
                VStack(spacing: 12) {
                    
                    ForEach(fetcher.feed[0].posts) { post in
                        PostView(post: Post(
                            post.id,
                            person_json(id: post.author.id, nickname: post.author.nickname, online: post.author.online, mutual: post.author.mutual),
                            post.date,
                            post.post_string,
                            post.post_media,
                            post.social_activity
                                )
                            )
                        }
                    

                }
                
                Spacer()
                
            }
        
    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
