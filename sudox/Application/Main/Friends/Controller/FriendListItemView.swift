//
//  FriendListItemView.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 16.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI

struct FriendListItemView: View {
    let person: Person
    var body: some View {
        HStack{
            Image("bigLogo")
                .renderingMode(.original)
                .resizable()
                .frame(width: 46, height: 46)
                .clipShape(Circle())
            
            VStack(alignment: .leading){
                Text(person.nickname)
                    .bold()
                    .font(.system(size: 14))
                
                if (person.online["online"] as! String == "0")
                {
                    Text("Online")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.globalGreen))  
                }
                else
                {
                    Text(person.online["last_seen"] as! String)
                        .font(.system(size: 14))
                        .opacity(0.5)
                }
            }.padding(.leading,16)
            Spacer()
            
            
            
        }.padding(.leading,16).padding(.trailing,16)
        
    }
}

struct FriendListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListItemView(
            person: Person(0, "isp13", ["online": true, "last_seen": "now"] , 23)
        )
    }
}
