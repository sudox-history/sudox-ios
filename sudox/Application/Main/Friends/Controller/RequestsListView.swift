//
//  RequestsListView.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 08.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI


struct friendRequest: Identifiable {
    var id: Int
    var nickname: String
    var online: [String: Any]
    var mutual: Int
    var requestText: String
}

struct RequestsListView : View {
    
    @EnvironmentObject var requestsList: FriendFetcher
    
    var body: some View {
        VStack {
            ForEach(requestsList.friends[0].requests, id: \.id) { request in
                HStack{
                    Image("bigLogo")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 46, height: 46)
                        .clipShape(Circle())
                        .onTapGesture {self.addRandomRequest()}
                    
                    VStack(alignment: .leading){
                        Text(request.person.nickname)
                            .bold()
                            .font(.system(size: 14))
                        
                        Text(request.text)
                            .font(.system(size: 14))
                            .opacity(0.5)
                            .lineLimit(1)
                        
                    }.padding(.leading,16)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor((Color(.globalGreen)))
                        .padding(.trailing,16)
                        .onTapGesture {self.requestsList.delete(obj: request)}
                    
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.red)
                        .onTapGesture {self.requestsList.delete(obj: request)}
                }
            }     
        }
    }
    
    func addRandomRequest() {
        
        let lastind = requestsList.friends[0].requests.last?.id ?? -1
        requestsList.friends[0].requests.append(Friend_request_list_item_json(id: lastind + 1, person: Friend_list_item_json(id: (requestsList.friends[0].requests.last?.id ?? -1) + 1, nickname: "isp13", online: ["online": "1", "last_seen": "now"], mutual: 23), text: "hello there" + String(lastind)))
    }
    
    func deleteRequest(id: Int)
    {
        requestsList.delete(tmp: id)
    }
    
}


/*
 struct RequestsListView_Previews: PreviewProvider {
 static var previews: some View {
 RequestsListView(requestsList: [Friend_request_list_item_json(id: 0, person: Friend_list_item_json(id: 0, nickname: "isp13", online: ["online": "1", "last_seen": "now"], mutual: 23), text: "hello there"),Friend_request_list_item_json(id: 0, person: Friend_list_item_json(id: 0, nickname: "isp13", online: ["online": "1", "last_seen": "now"], mutual: 23), text: "hello there"),Friend_request_list_item_json(id: 0, person: Friend_list_item_json(id: 0, nickname: "isp13", online: ["online": "1", "last_seen": "now"], mutual: 23), text: "hello there")])
 }
 }
 */
