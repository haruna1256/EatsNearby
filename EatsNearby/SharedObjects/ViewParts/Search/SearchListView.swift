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
    var body: some View {
        GeometryReader { geometry in
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

                HStack(spacing: 0) {
                    Text(condition.title)
                        .font(.caption2)
                        .lineLimit(1)
                    Spacer()
                    Button {
                        print("検索")
                    } label: {
                        Text("\(condition.placeholder) >")
                            .foregroundStyle(Color("accentColor"))
                            .font(.caption)
                    }



                }
            }

            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(Color("bgColor"))
            .cornerRadius(8)
            .frame(width: geometry.size.width * 0.8, height: 72)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }

    }
}

#Preview {
    SearchListView(
        condition: .genre
    )
}
