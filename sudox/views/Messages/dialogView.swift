//
//  dialog.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 22.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI

struct Dialog: View {
    let name: String
    let image: String
    let last_message: String
    let was_read: Bool
    let last_message_time: String
    let count_unread_messages: Int
    let online: Bool
    var body: some View {
        
        HStack(alignment: .top){
            Image(image)
                .renderingMode(.original)
                .resizable()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
            
            VStack(alignment: .leading)
            {
                Text(name).bold()
                
                Text(last_message)
                    .font(.system(size: 14))
                    .padding(.leading,0)
                    .multilineTextAlignment(.leading)
                
            }
            Spacer()
            VStack(alignment: .trailing){
                HStack
                    {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 14, height: 11)
                            .foregroundColor(.green)
                            .padding(.top, 2)
                        
                        Text(last_message_time)
                            .font(.system(size: 14))
                            .opacity(0.5)
                }
                
                if (String(count_unread_messages).count == 1 && count_unread_messages != 0 )
                {
                    Text(String(count_unread_messages))
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        
                        .padding(.leading,5)
                        .padding(.trailing,5)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                else if (String(count_unread_messages).count > 1)
                {
                    Text(String(count_unread_messages))
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .fixedSize()
                        .padding(.leading,5)
                        .padding(.trailing,5)
                        .background(Color.green)
                        .cornerRadius(25.0)
                }
                
                
            }
            
        }.padding(.leading,16).padding(.trailing,16)
    }
}
