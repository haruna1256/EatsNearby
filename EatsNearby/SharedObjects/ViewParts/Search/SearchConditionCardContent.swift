//
//  SearchConditionCardContent.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import SwiftUI

// リストコンテナ
struct SearchConditionCardContent: View {
    @EnvironmentObject var settings: SearchSettings
    
    var body: some View {
        VStack(spacing: 0) {

            // ジャンル
            SearchExpandableRow(
                condition: .genre,
                isExpanded: $settings.isGenreExpanded,
                selectedItem: $settings.selectedGenre
            )
            // 展開されている場合はDividerを表示しない
            if !settings.isGenreExpanded {
                Divider().padding(.horizontal, 16)
            }

            // 予算
            SearchExpandableRow(
                condition: .budget,
                isExpanded: $settings.isBudgetExpanded,
                selectedItem: $settings.selectedBudget
            )
            if !settings.isBudgetExpanded {
                Divider().padding(.horizontal, 16)
            }

            // こだわり条件 (チェックマーク形式)
            SearchOptionRow()
        }
    }
}

#Preview {
    // プレビュー表示したいビューのインスタンスを作成
    SearchConditionCardContent()
    // 必須: ダミーの SearchSettings インスタンスを注入する
    .environmentObject(SearchSettings())

    // プレビューを見やすくするために、背景やパディングを追加しても良い
    .padding()
    .background(Color(.systemGray6))
}
