//
//  Home.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/5.
//

import SwiftUI

struct Home: View {
    
    /// 商品
    @State var items = [
        HomeItem(title: "SVALLET 斯瓦雷特", price: "¥29.99", subTitle: "工作灯,深灰色/白色", image: "lamp"),
        HomeItem(title: "OSKARSHAMN 奥卡珊", price: "¥1299.00", subTitle: "靠背椅，提伯勒比 米色/灰色", image: "chair"),
        HomeItem(title: "STIG 斯帝格", price: "¥129.00", subTitle: "靠背吧凳, 黑色/黑色，74 厘米，吧台椅热销榜第1名", image: "stool"),
    ]
    
    /// 购物车
    @State var carts: [HomeItem] = []
    
    /// 收藏
    @State var collects: [HomeItem] = []
    
    @GestureState var isDragging = false
    
    var body: some View {
        VStack {
            // 导航
            CustomNavBar(carts: $carts)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Introduce()
                    
                    List()
                }
            }
        }
    }
    
    // MARK: - UI
    fileprivate func Introduce() -> some View {
        return HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Furniture in \nIKEA")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Text("宜家榜单，人气之选")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
    
    fileprivate func List() -> ForEach<[EnumeratedSequence<[HomeItem]>.Element], Int, some View> {
        return ForEach(Array(items.enumerated()), id: \.offset) { index, item in
            ZStack {
                // 底部背景
                CardBack(item, index: index)
                
                // 商品
                GoodsCard(item: item)
                // 设置偏移量
                    .offset(x: item.offset)
                    .gesture(
                        // 拖拽手势
                        DragGesture()
                            .updating($isDragging, body: { (value, state, _) in
                                state = true
                                onChanged(value, index: index)
                            }).onEnded({ (value) in
                                onEnd(value, index: index)
                            })
                    )
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    fileprivate func CardBack(_ item: HomeItem, index: Int) -> some View {
        return ZStack {
            Color("tab")
                .cornerRadius(20)
            Color("bg")
                .cornerRadius(20)
                .padding(.trailing, 65)
            
            HStack {
                Spacer()
                
                Button(action: {
                    addCollect(index)
                }) {
                    Image(systemName: isCollect(item) ? "suit.heart.fill" : "suit.heart")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 65)
                }
                
                Button(action: {
                    addCart(index)
                }) {
                    Image(systemName: isAddCart(item) ? "cart.badge.minus" : "cart.badge.plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 65)
                }
            }
        }
    }
    
    // MARK: - Method
    func isAddCart(_ item: HomeItem) -> Bool {
        return carts.contains { descItem in
            return descItem.id == item.id
        }
    }
    
    func isCollect(_ item: HomeItem)->Bool{
        return collects.contains { descItem in
            return descItem.id == item.id
        }
    }
    
    func addCart(_ index: Int) {
        let item = items[index]
        if isAddCart(item) {
            carts.remove(at: index)
        } else {
            carts.append(item)
        }
        withAnimation {
            items[index].offset = 0
        }
    }
    
    func addCollect(_ index: Int) {
        let item = items[index]
        if isCollect(item) {
            collects.remove(at: index)
        } else {
            collects.append(item)
        }
        withAnimation {
            items[index].offset = 0
        }
    }
    
    func onChanged(_ value: DragGesture.Value, index: Int) {
        if value.translation.width < 0 && isDragging {
            items[index].offset = value.translation.width
        }
    }
    
    func onEnd(_ value: DragGesture.Value, index: Int) {
        withAnimation {
            if -value.translation.width >= 100 {
                items[index].offset = -130
            } else {
                items[index].offset = 0
            }
        }
    }
}


struct CustomNavBar: View {
    
    @Binding var carts: [HomeItem]
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .overlay(
                Text("\(carts.count)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .frame(width: 20, height: 20)
                    .background(Color("tab"))
                    .clipShape(Circle())
                    .offset(x: 15, y: -22)
                    .opacity(carts.isEmpty ? 0 : 1)
            )
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 10)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
