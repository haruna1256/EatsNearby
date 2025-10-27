//
//  HeaderView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/27.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 48)
            Spacer()
        }
        .padding(.horizontal, 8)
        .frame(height: 60)
        .background(
            Image("bgImage")
                .resizable()
                .scaledToFill()
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
        )
    }
}

#Preview {
    HeaderView()
}
