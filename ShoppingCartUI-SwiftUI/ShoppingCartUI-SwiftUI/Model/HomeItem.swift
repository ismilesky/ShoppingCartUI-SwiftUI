//
//  HomeItem.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/5.
//

import Foundation

struct HomeItem: Identifiable {
    
    var id = UUID().uuidString // 标识
    var title: String          // 标题
    var price: String          // 价格
    var subTitle: String       // 副标题
    var image: String          // 图片
    var offset: CGFloat = 0    // 偏移量
}
