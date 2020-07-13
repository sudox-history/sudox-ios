//
//  story.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import SwiftUI

// ячейка историй. Т.е. единичный экземпляр. прописываю тут ему дизайн
struct Moments_item: View {
    let person: Person
    let was_viewed: Bool
    let containment: String
    
    var body: some View {
        
        VStack {
            ZStack {
                Group {
                    // изображение автора
                    Image("smallNick")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(!was_viewed ? (Color(.globalGreen)): Color.clear, lineWidth: 4).opacity(0.7))
                }
                
                // если история была уже просмотрена, то окрасить в серый
                if (was_viewed)
                {
                    Circle().frame(width: 62, height: 62)
                        .foregroundColor(.clear)
                        .overlay(Circle().stroke(Color.white .opacity(0.5), lineWidth: 1.5))
                }
                
                
                Circle().frame(width: 58, height: 58)
                    .foregroundColor(.clear)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2).opacity(1))
                
                // проверка на себя (первая история -  владельца аккаунта)
                if(person.nickname == "isp13")
                {
                    ZStack {
                        Circle().frame(width: 24, height: 24).padding(.top,40)
                            .padding(.leading, 37).foregroundColor(.white)
                        Circle().frame(width: 20, height: 20).padding(.top,40)
                            .padding(.leading, 37).foregroundColor((Color(.globalGreen)))
                        
                        Image(systemName: "plus.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .colorInvert()
                            .overlay(Circle().stroke(Color.white .opacity(0.5), lineWidth: 1.4))
                            .opacity(1)
                            .padding(.top,40)
                            .padding(.leading, 37)
                    }
                    
                }
            }
            
            Text(person.nickname)
                .font(.system(size: 12))
                .lineLimit(nil)
                .foregroundColor((Color(.systemGray )))
                .frame(width: 60)
            
        }
    }
}
