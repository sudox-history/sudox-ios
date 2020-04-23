//
//  StoryItem.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//


import SwiftUI

struct Story: View {
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
            VStack{
                All_moments()
                
            }
            
            }.edgesIgnoringSafeArea(.horizontal)
    }
}

// структура выводящая все истории на экран
struct All_moments: View {
    var body: some View {
        VStack {
            HStack {
                Text("Moments").bold().padding(.leading, 16)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Moments_item(person: Person(0, "isp13", ["online": true, "last_seen": "now"] , 23), was_viewed: true, containment: "rnd1")
                    Moments_item(person: Person(1, "kerjen", ["online": true, "last_seen": "now"] , 23), was_viewed: false, containment: "rnd1")
                    Moments_item(person: Person(2, "idiot", ["online": true, "last_seen": "now"] , 23), was_viewed: false, containment: "rnd1")
                    Moments_item(person: Person(3, "my_friend", ["online": true, "last_seen": "now"] , 23), was_viewed: true, containment: "rnd1")
                    Moments_item(person: Person(4, "gergeee", ["online": true, "last_seen": "now"] , 23), was_viewed: true, containment: "rnd1")
                }.padding(.leading, 16)
                
            }
            
        }
    }
}



struct Story_Previews: PreviewProvider {
    static var previews: some View {
        Story()
    }
}
