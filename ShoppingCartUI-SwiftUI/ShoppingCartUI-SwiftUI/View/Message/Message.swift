//
//  Message.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/5.
//

import SwiftUI

var titles = ["关注","推荐","收藏"]

struct Message: View {
    
    @State var selectedTab = "关注"
    @Namespace var aniamtion
    
    var body: some View {
        VStack(spacing: 0) {
           
            TopView(selectedTab: $selectedTab, animation: aniamtion)
    
            ZStack {
                Color("bg")
                Color.white
                    .clipShape(CustomShape(corners: .topRight, size: 65))
                MessageList()
            }
        }
        .background(Color.white.ignoresSafeArea())
        .edgesIgnoringSafeArea(.top)
    }
}


struct TopView: View {
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            
            VStack {
                Text("消息(41)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top, 45)
            .padding(.bottom, 10)
            
            HStack(spacing: 20) {
                ForEach(titles, id: \.self) { title in
                    CateTabButton(selectedTab: $selectedTab, title: title, animation: animation)
                }
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .cornerRadius(15)
            .padding(.vertical)
        }
        .padding(.bottom)
        .background(Color("bg"))
        .clipShape(CustomShape(corners: .bottomLeft, size: 65))
    }
}

struct CateTabButton: View {
    @Binding var selectedTab: String
    var title: String
    var animation: Namespace.ID

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = title
            }
        }, label: {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    ZStack {
                        if selectedTab == title {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("bg"))
                                .matchedGeometryEffect(id: "Tab", in: animation)
                        }
                    }
                )
        })
    }
}

struct MessageList: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 20) {
                HStack {
                    Text("全部")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                    })
                }
                .padding()

                ForEach(datas, id: \.groupName) { gData in
                    HStack {
                        Text(gData.groupName)
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()
                    }
                    .padding(.horizontal)
                    ForEach(gData.messages) { message in
                        MessageCell(message: message)
                    }
                }
            }
            .padding(.vertical)
        })

    }
}

struct Message_Previews: PreviewProvider {
    static var previews: some View {
        Message()
    }
}
