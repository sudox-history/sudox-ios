//
//  FriendsListView.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 18.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI

struct FriendsListView: View {
    @ObservedObject var fetcher = FriendFetcher()
    
    @State var requestsHidden : Bool = false
    @State var CardsHidden : Bool = false
    @State var FriendListHidden : Bool = false
    
    init() {
        // To remove only extra separators below the list:
        
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
    }
    
    
    var body: some View {
        
        // заявки в друзья
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                
                HStack {
                    Text("Friend Requests").bold().contextMenu{
                        Button("Add new request") {self.fetcher.append_rnd()}
                        Button("Delete request") {self.fetcher.delete(tmp: 0)}
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 16, height: 10)
                        .foregroundColor((Color(.globalGreen)))
                        .onTapGesture {
                            self.requestsHidden.toggle()
                    }
                    
                    
                }.padding()
                
                if (!self.requestsHidden)
                {
                    RequestsListView()
                        .environmentObject(fetcher)
                        .padding(.leading,16)
                        .padding(.trailing,16)
                }
                
                // карточки "Может быть вы знаете"
                HStack {
                    Text("Maybe you know").bold()
                    Spacer()
                    Button(action: {
                        // your action here
                        self.CardsHidden.toggle()
                    }) {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .foregroundColor((Color(.globalGreen)))
                    }
                    
                }.padding()
                
                if (!self.CardsHidden) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(fetcher.friends[0].maybeYouKnowCards) { card in
                                MaybeYouKnowCardView(person: Person(card.person.id, card.person.nickname, card.person.online , card.person.mutual))
                            }
                            .padding(.leading, 16)
                        }
                        
                    }
                }
                // список друзей
                HStack {
                    
                    Text("Friends").bold()
                    Button(action: {
                        // your action here
                        self.FriendListHidden.toggle()
                    }) {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .foregroundColor((Color(.globalGreen)))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // your action here
                    }) {
                        Image(systemName: "chevron.up.chevron.down")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor((Color(.globalGreen)))
                    }.contextMenu{
                        Button("Importance") {self.fetcher.sort(sortType: 1)}
                        Button("Online") {self.fetcher.sort(sortType: 2)}
                        Button("Name") {self.fetcher.sort(sortType: 3)}
                    }
                }.padding()
                
                if (!self.FriendListHidden){
                    ForEach(fetcher.friends[0].friendList) { friend in
                        VStack (alignment: .leading) {
                            FriendListItemView(person:
                                Person(friend.id, friend.nickname, friend.online, 0)
                            )
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .listRowInsets(EdgeInsets())
                }
                Spacer()
                
            }
        }
    }
}

struct FriendsListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListView()
    }
}



