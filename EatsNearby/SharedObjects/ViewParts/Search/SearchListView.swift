//
//  SearchListView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//
import SwiftUI

// 検索項目のリスト
struct SearchListView: View {
    // 検索条件の定義から取得
    let condition: SearchCondition
    let currentValue: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack() {
                    Rectangle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color("accentSubColor"))
                    Image(condition.iconName)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .cornerRadius(8)
                // テキストと値の表示
                HStack(spacing: 0) {
                    Text(condition.title)
                        .font(.caption2)
                        .foregroundStyle(Color("textColor"))
                        .lineLimit(1)
                    Spacer()
                    HStack(spacing: 2) {
                        // 条件を設定したかどうかで色を変える
                        Text(currentValue)
                            .foregroundStyle(Color(currentValue == condition.placeholder ? Color("accentColor") : .primary))
                            .font(.caption)
                        // 明示的な矢印（トグルのために必要）
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(Color("accentColor"))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color("bgColor"))
            .cornerRadius(8)
            .frame(height: 72)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        }

    }

}


#Preview {
    Color(.systemGray6)
        .ignoresSafeArea()
        .overlay(
            VStack {
                // プレースホルダーが表示されている状態のプレビュー
                SearchListView(
                    condition: .genre,
                    currentValue: SearchCondition.genre.placeholder,
                    action: { print("ジャンル行がタップされました") }
                )

                Divider().padding(.horizontal, 16)

                // 値が選択されている状態のプレビュー
                SearchListView(
                    condition: .budget,
                    currentValue: "〜5000円",
                    action: { print("予算行がタップされました") }
                )
            }
            // 行の背景色をシミュレート
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .padding()
        )
}

