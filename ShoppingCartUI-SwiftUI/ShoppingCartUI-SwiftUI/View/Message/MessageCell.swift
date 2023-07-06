//
//  MessageCell.swift
//  ShoppingCartUI-SwiftUI
//
//  Created by edy on 2023/7/6.
//

import SwiftUI

struct MessageCell: View {
    var message: MessageItem
    var body: some View {
        HStack(spacing: 10) {
            Image(message.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(message.name)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(message.msg)
                    .font(.caption)
                    .lineLimit(1)
            })
            
            Spacer(minLength: 0)
            
            Text(message.time)
                .font(.system(size: 15))
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
    
}

