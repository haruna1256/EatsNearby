//
//  SearchExpandableRow.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//

import SwiftUI

// 汎用的なトグル可能行コンポーネント
struct SearchExpandableRow<Item: SelectableItem>: View {
    @EnvironmentObject var settings: SearchSettings

    let condition: SearchCondition
    @Binding var isExpanded: Bool // 展開状態のバインディング
    @Binding var selectedItem: Item? // 選択結果のバインディング

    var body: some View {
        // リスト行本体 (タップで展開/折りたたみ)
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
        } label: {
            HStack(spacing: 16) {
                // アイコン部分
                ZStack() {
                    Rectangle().frame(width: 40, height: 40).foregroundStyle(Color("accentSubColor")).cornerRadius(8)
                    Image(condition.iconName).resizable().frame(width: 32, height: 32)
                }

                // テキストと値の部分
                HStack(spacing: 0) {
                    Text(condition.title)
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundStyle(.primary)

                    Spacer()

                    let currentValue = selectedItem?.displayName ?? condition.placeholder
                    Text(currentValue)
                        .foregroundStyle(currentValue == condition.placeholder ? Color("accentColor") : .primary)
                        .font(.subheadline)

                    // 展開状態に応じて矢印を回転させる
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(Color.secondary.opacity(0.6))
                        .rotationEffect(.degrees(isExpanded ? 90 : 0)) // 矢印の回転
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)

        // 選択肢リスト (展開時のみ表示)
        if isExpanded {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(Item.allCases.enumerated()), id: \.element) { _, item in
                    Button {
                        if selectedItem == item {
                            selectedItem = nil
                        } else {
                            selectedItem = item
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isExpanded = false
                            }
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Spacer().frame(width: 40 + 16)
                            Text(item.displayName)
                            Spacer()
                            if selectedItem == item {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                            }
                            Spacer().frame(width: 10)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundStyle(.primary)
                        .background(selectedItem == item ? Color.gray.opacity(0.1) : Color.clear)
                    }
                    .buttonStyle(.plain)
                    Divider().padding(.leading, 16 + 40 + 16)
                }
            }
        }
    }
}
