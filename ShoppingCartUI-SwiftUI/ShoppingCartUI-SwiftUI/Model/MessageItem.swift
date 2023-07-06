//
//  MessageItem.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/6.
//

import Foundation


struct MessageItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var msg: String
    var time: String
}


struct MessageGroup {
    var groupName: String
    var messages: [MessageItem]
}


var newList: [MessageItem] = [
    MessageItem(name: "优惠促销", image: "p0", msg: "家电安装特价只为你，233元领走不客气", time: "10:45"),
    MessageItem(name: "蓝月亮", image: "p1", msg: "😁别走弯路了！这款洗衣液真的不会踩坑.....", time: "03:45"),
    MessageItem(name: "客服助手", image: "p2", msg: "感谢您于2023年06月25日10:39:40咨询....", time: "04:55"),
    MessageItem(name: "美的官方客服-空调", image: "p3", msg: "嗯呢", time: "06:25"),
    MessageItem(name: "小米自营旗舰店", image: "p4", msg: "预约上门需要等待", time: "07:19"),
    MessageItem(name: "泡泡玛特旗舰店", image: "p5", msg: "22点泡泡上新开售啦！！", time: "08:22")
]

var oldList: [MessageItem] = [
    MessageItem(name: "戴森", image: "p4", msg: "618年中大促，优惠好物现实集结", time: "02:45"),
    MessageItem(name: "VANS官方旗舰店", image: "p1", msg: "今晚20点 预售开启，限时送定金", time: "03:45"),
    MessageItem(name: "兰蔻", image: "p3", msg: "手慢无，PLUS会员购制定正装限制额外......", time: "04:55")
]

var datas = [
    MessageGroup(groupName: "最近", messages: newList),
    MessageGroup(groupName: "2周前", messages: oldList)
]
