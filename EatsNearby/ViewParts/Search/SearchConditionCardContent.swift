//
//  SearchConditionCardContent.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import SwiftUI

// 条件を表示するUI
struct SearchConditionCardContent: View {
    @ObservedObject var  settings: SearchSettings

    var body: some View {
        VStack(spacing: 0) {

            // ジャンル
            SearchExpandableRow(
                settings: settings,
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
                settings: settings,
                condition: .budget,
                isExpanded: $settings.isBudgetExpanded,
                selectedItem: $settings.selectedBudget
            )
            if !settings.isBudgetExpanded {
                Divider().padding(.horizontal, 16)
            }

            // こだわり条件 (チェックマーク形式)
            SearchOptionRow(settings: settings)
        }
        .environmentObject(settings)
    }
}

struct SearchConditionCardContent_Previews: PreviewProvider {
        static var previews: some View {
            // ダミーの SearchSettings インスタンスを作成
            let dummySettings = SearchSettings()
            SearchConditionCardContent(settings: dummySettings)
                .padding()
                .background(Color(.systemGray6))
                .previewLayout(.sizeThatFits)
        }
}
