//
//  StoreListView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/19.
//

import SwiftUI

struct StoreListView: View {
//    店の情報を受け取る変数
//    let store: Store
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Rectangle()
                    .frame(width: 72, height: 64)
                    .background(Color("accentSubColor"))
                Image("store_image")
                    .resizable()
                    .frame(width: 72, height: 64)
            }
            VStack(alignment: .leading) {
                Text("お店の名前")
                    .font(.subheadline)
                HStack(spacing: 0) {
                    Text("お店の場所")
                        .font(.caption2)
                        .lineLimit(1)
                    Spacer()
                    Text("現在地からの距離")
                        .font(.caption)
                        .frame(maxHeight: .infinity, alignment: .bottom)

                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color("bgColor"))
        .cornerRadius(8)
        .shadow(color: Color("accentColor").opacity(0.1), radius: 3, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .frame(height: 72)
    }
}

#Preview {
    StoreListView()
}
