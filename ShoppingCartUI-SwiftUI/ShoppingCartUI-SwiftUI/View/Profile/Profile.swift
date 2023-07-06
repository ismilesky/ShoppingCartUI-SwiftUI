//
//  Profile.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/5.
//

import SwiftUI


enum Period {
    case today, yesterday, lastWeek
}



struct Profile: View {
    @State private var period: Period = .today
    @State private var selected = 0
        
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 35) {
                    VStack {
                        HStack {
                            Text("消费仪表盘")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.vertical)

                        CategoryView(period: $period)
                        PanelsView()
                    }
                    .padding(.horizontal)
                    .padding(.top, 45)

                    
                    DetailView(selected: $selected)
                }
                .background(Color("bg").edgesIgnoringSafeArea(.top))
                
            }
            .edgesIgnoringSafeArea(.top)
//            .background(Color("bg").edgesIgnoringSafeArea(.top))

    }
}

struct CategoryView: View {
    @Binding var period: Period
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    period = .today
                }
            }) {
                Text("今天")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(period == .today ? 1 : 0.4))
                    .padding(.horizontal)
            }
            
            Button(action: {
                withAnimation {
                    period = .yesterday
                }
            }) {
                Text("昨天")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(period == .yesterday ? 1 : 0.4))
                    .padding(.horizontal)
            }
            
            Button(action: {
                withAnimation {
                    period = .lastWeek
                }
            }) {
                Text("上周")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(period == .lastWeek ? 1 : 0.4))
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}


struct PanelsView: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                Panel(categoryText: "购物车", value: 18789, bgColors: Color.hextoRGB(colors: ["#ff512f","#f09819"]))
                Panel(categoryText: "收藏", value: 1089, bgColors: Color.hextoRGB(colors: ["#1d976c","#93f9b9"]))
            }
            
            HStack(spacing: 15) {
                Panel(categoryText: "支付", value: 18789, bgColors: Color.hextoRGB(colors: ["#00c6ff","#0072ff"]))
                Panel(categoryText: "返现", value: 2089, bgColors: Color.hextoRGB(colors: ["#4776e6","#845ee9"]))
                Panel(categoryText: "取消", value: 1089, bgColors: Color.hextoRGB(colors: ["#add100","#7b920a"]))
            }
        }
    }
}

struct Panel: View {
    var categoryText: String
    var value: Int
    var bgColors: [Color]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryText)
                .font(.callout)
                .padding(.bottom)
            
            Text(String(format: "%d", locale: Locale.current, value))
                .font(.title3)
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(gradient: Gradient(colors: bgColors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
    }
}



struct DetailView: View {
    
    @Binding var selected: Int
    
    let calendar = Calendar.current
    let today = Date()
    
    var body: some View {
        ZStack {
            Color.white
                .clipShape(CustomShape(corners: [.topLeft, .topRight], size: 40))
            
            VStack(alignment: .leading) {
                Text("明细")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 30)
                
                Spacer()
                
                HStack(spacing: 0) {
                    ForEach(0..<7) { day in
                        // 获取前七天
                        Bar(
                            value: soldUnitData[day],
                            date: DateFormatter.chartDateFormatter.string(from: calendar.date(byAdding: .day, value: day - 7, to: today)!),
                            selected: selected == day)
                            .onTapGesture {
                                withAnimation {
                                    selected = day
                                }
                            }
                    }
                }
                .frame(height: 300)
                .padding(.bottom, 50)
            }
            .padding(.horizontal)
        }
    }
}

struct Bar: View {
    var value: CGFloat
    var date: String
    var selected: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            GeometryReader { geo in
                VStack() {
                    Spacer()
                    
                    if (selected) {
                        Text(String(format: "%.0f", locale: Locale.current, value))
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                        
                    RoundedRectangle(cornerRadius: 5)
                        .fill(LinearGradient(gradient: Gradient(colors: Color.hextoRGB(colors: ["#ffb75e","#ed8f03"], alpha: selected ? 1.0 : 0.5)), startPoint: .top, endPoint: .bottom))
                        .frame(width: geo.frame(in: .local).width / 100 * 70, height: (value / 1000) * geo.frame(in: .local).height)
                }
                .padding(.horizontal, geo.frame(in: .local).width / 100 * 15)
                .frame(height: geo.frame(in: .local).height)
            }
            Text(date)
                .font(.caption2)
        }
    }
}

var soldUnitData: [CGFloat] = [358, 516, 877, 456, 244, 834, 843]


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
