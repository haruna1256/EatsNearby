//
//  SearchIconView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/22.
//
import SwiftUI
// 検索画面に遷移するボタンのアイコン

struct SearchIconView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color("accentColor"))

            Image("search")
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
        }
        .frame(width: 64, height: 64)
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    SearchIconView()
}
