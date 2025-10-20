//
//  DitailPage.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//

import SwiftUI

struct DitailPage: View {

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    // 画像が入る想定の領域
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: geometry.size.height / 2)
                    Image("")
                        .resizable()
                        .frame(height: geometry.size.height / 2)
                }

                // テキスト群が入る想定の領域
                VStack(alignment: .leading, spacing: 4) {
                    Text("レストラン名")
                    Text("レストランのジャンル")
                        .font(.caption)
                    HStack(spacing: 4) {
                        Text("住所")
                        Text("東京都にあるよ")

                    }

                    HStack(spacing: 4) {
                        Text("営業時間")
                        Text("月、火")
                    }
                    HStack(spacing: 4) {
                        Text("電話番号")
                        Text("090-4444-9999")
                    }
                    HStack(spacing: 4) {
                        Text("平均予算")

                    }
                    HStack(spacing: 4) {
                        Text("飲み放題 食べ放題")

                    }
                    HStack(spacing: 4) {
                        Text("総席数")

                    }

                }
                HStack(spacing: 0) {
                    Button {
                        print("道のりの表示")
                    } label: {
                        Text("ルート")
                    }
                    Button {
                        print("電話をかける")
                    } label: {
                        Text("電話")
                    }


                }
            }
        }
    }
}

#Preview {
    DitailPage()
}
