//
//  PostView.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 12.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//



import SwiftUI

struct PostView: View {
    @State var post: Post

    @State var isSelected : Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading)
        {
            // верхняя строка поста с никнеймом автора и датой создания поста
            UpperPostLine(post: $post)
            
            // текст поста
            PostText(isSelected: $isSelected, post: $post)
            
            // картинка
            Image(post.post_media[0])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .cornerRadius(15, corners: [.topRight, .bottomLeft])
                .cornerRadius(15, corners: [.bottomRight])
                .cornerRadius(5, corners: [.topLeft])
                .padding(.leading,16)
                .padding(.trailing,16)
            
            // нижняя строка view с кнопками лайка/дизлайка/комментами
            BottomPostLine(post: $post)
            
        }.edgesIgnoringSafeArea(.horizontal)
        
    }
}

struct PostView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        PostView(
            
            post: Post(0,
            person_json(id: 1, nickname: "isp13", online: ["online": "0", "last_seen": "now"], mutual: 32),
            "today at 16:11",
            "Lorem ips um dolor sit amet, conse ctetur adi pi scing elit, sed do eiu smod tempor inci didun t ut labo re et dolore magn a aliqua. L orem ip sum dolor sit amet, consec tetur adip iscing elit, sed do eiusmo d tempor inc ididu nt ut labore et do lore magna aliqua.",
            ["breakingbad"],
            Media_activity(2,41, 2, 7, 3, 1) )
        )
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct PostText: View {
    @Binding var isSelected: Bool
    @Binding var post: Post
    var body: some View {
        // отображение текста поста + возможность разворачивания большого текста
        Group{
            if (post.post_string.count > 120 && isSelected == false)
            {
                
                Text( post.post_string.prefix(120) + "...")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 16))
                    .lineLimit(nil)
                    .padding(.leading,16)
                    .padding(.trailing,16)
                    .frame(alignment: .leading)
                
                
                Button(action: {
                    // expand text
                    self.isSelected.toggle()
                }) {
                    
                        Text("read more...")
                            .foregroundColor((Color(.globalGreen)))
                            .font(.system(size: 16))
                            .opacity(0.8)
                            .padding(.leading,16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
            }
            else{
                Text( post.post_string)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 16))
                    .lineLimit(nil)
                    .padding(.leading,16)
                    .padding(.trailing,16)
                    .frame(alignment: .leading)
            }
        }
    }
}

struct UpperPostLine: View {
    @Binding var post: Post
    var body: some View {
        HStack{
            ZStack {
                // фото автора
                Image("smallNick")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 46, height: 46)
                    .clipShape(Circle())
                // иконка онлайна автора
                /*
                if (post.author.online["online"] as! String == "1" ? true: false)
                {
                    Circle()
                        .foregroundColor((Color(.globalGreen)))
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .frame(width: 15, height: 15)
                        .padding(.top,35)
                        .padding(.leading, 40)
                }
                */
            }.padding(.leading, 16)
            
            VStack(alignment: .leading) {
                
                //author nickname
                Text(post.author.nickname)
                    .bold()
                    .font(.system(size: 14))
                
                //author last seen time
                Text(post.date)
                    .font(.system(size: 14))
                    .opacity(0.7)
                    .padding(.top,5)
                    .foregroundColor((Color(.systemGray )))
                
            }.padding(.leading, 10)
            
            Spacer()
            
            // editing button for post on the right
            Image(systemName: "ellipsis")
                .padding(.trailing, 0)
                .rotationEffect(.degrees(-90), anchor: .bottomLeading)
                .foregroundColor((Color(.systemGray )))
        }
    }
}

struct BottomPostLine: View {
    @Binding var post: Post
    var body: some View {
        HStack{
            
            // кнопка лайка
            Button(action: {
                // your action here
            }) {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor((Color(.globalGreen)))
                    
                    
                // кол-во лайков
                Text(String(post.social_activity.likes))
                    .font(.system(size: 14))
                    .foregroundColor((Color(.systemGray )))
            }
             
            Spacer()
            
            // иконка комментария
            Button(action: {
                // your action here
            }) {
            
            Image(systemName: "bubble.left")
                .resizable()
                .frame(width: 18, height: 15)
                .foregroundColor((Color(.systemGray )))
            
            // отображение кол-ва комментариев
            Text(String(post.social_activity.comments))
                .font(.system(size: 14))
                .foregroundColor((Color(.systemGray )))
            }
            Spacer()
            
            // кнопка поделиться
            Button(action: {
            }) {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .foregroundColor((Color(.globalGreen)))
                
                // отображение кол-ва поделиться
                Text(String(post.social_activity.shares))
                    .font(.system(size: 14))
                    .foregroundColor((Color(.systemGray )))
            }
            
            
            Spacer()
            
            // кнопка дизлайка
            Button(action: {
            }) {
                Image(systemName: "hand.thumbsdown")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor((Color(.systemGray )))
                
                // отображение кол-ва дизлайков
                Text(String(post.social_activity.dislikes))
                    .font(.system(size: 14))
                    .foregroundColor((Color(.systemGray )))
                
            }
            
            
            
                
            
        }.padding(.top, 10).padding(.trailing,16).padding(.leading,16)
    }
}
