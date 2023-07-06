//
//  TabBar.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/5.
//

import SwiftUI

struct TabBar: View {
    
    @State var currentTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {

            
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.home)
                Message()
                    .tag(Tab.message)
                Profile()
                    .tag(Tab.profile)
            }
            
            BottomBar(currentTab: $currentTab)
        }
    }
}


/// 底部栏
struct BottomBar: View {
    @Binding var currentTab: Tab

    var body: some View {
        HStack(spacing: 0) {
            TabBarItem(imgName: Tab.home.rawValue, title: "首页", currentTab: $currentTab)
            Spacer()
            TabBarItem(imgName: Tab.message.rawValue, title: "消息", currentTab: $currentTab)
            Spacer()
            TabBarItem(imgName: Tab.profile.rawValue, title: "我的", currentTab: $currentTab)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color("tab"))
        .clipShape(Capsule())
        .padding(.horizontal, 25)
    }
}

/// 点击item
struct TabBarItem: View {
    var imgName: String
    var title: String
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack(spacing: 0.0) {
            Button(action: {
                withAnimation(.spring()) {
                    currentTab = Tab(rawValue: imgName)!
                }
            }) {
                HStack(spacing: 10) {
                    Image(imgName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                    
                    if currentTab.rawValue == imgName {
                        Text(title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white.opacity(currentTab.rawValue == imgName ? 0.08 : 0))
                .clipShape(Capsule())
            }
        }
    }
}


enum Tab: String {
    case home = "home"
    case message = "message"
    case profile = "user"
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
