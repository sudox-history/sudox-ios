//
//  MaybeYouKnowCardView.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 15.02.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI

struct MaybeYouKnowCardView: View {
    let person: Person
    
    var body: some View {
        VStack
            {
                ZStack {
                    Image("bigLogo")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 66, height: 66)
                        .clipShape(Circle())
                    
                    if (person.online["online"] as! String == "1")
                    {
                        Circle()
                            .foregroundColor(Color(.globalGreen))
                            .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                            .frame(width: 14, height: 14)
                            .padding(.top,50)
                            .padding(.leading, 40)
                    }
                }
                
                Text(person.nickname)
                    .bold()
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                
                Text(String(person.mutual) + " mutual friends")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
        }
        .frame(width: 140, height: 160)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(UIColor.grayBorder), lineWidth: 1)
        )
        
    }
}


struct MaybeYouKnowCardView_Previews: PreviewProvider {
    static var previews: some View {
        MaybeYouKnowCardView(
            person: Person(0, "isp13", ["online": true, "last_seen": "now"] , 23)
        )
    }
}
// jregnjrtngirjtbni

