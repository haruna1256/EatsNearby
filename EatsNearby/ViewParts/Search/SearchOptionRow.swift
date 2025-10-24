//
//  SearchOptionRow.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import SwiftUI
// その他の条件を選択する複数トグルビュー
struct SearchOptionRow: View {
    @ObservedObject var settings: SearchSettings
    let condition: SearchCondition = .options // 固定
    let accentColor = Color("accentColor")
    let accentSubColor = Color("accentSubColor")

    // 現在選択されている項目をサマリー表示するための計算プロパティ
    var summaryText: String {
        if settings.selectedOptions.isEmpty {
            return condition.placeholder
        } else {
            // 選択された項目の表示名をカンマ区切りで結合
            let sortedOptions = settings.selectedOptions.sorted(by: { $0.displayName < $1.displayName })

            let names = sortedOptions.map { $0.displayName }

            return names.joined(separator: ", ")
        }
    }

    var body: some View {
        // リスト行本体 (タップで展開/折りたたみ)
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                settings.isOptionsExpanded.toggle()
            }
        } label: {

            HStack(spacing: 16) {
                // アイコン部分
                ZStack() {
                    Rectangle().frame(width: 40, height: 40).foregroundStyle(accentSubColor).cornerRadius(8)
                    Image(condition.iconName).resizable().frame(width: 32, height: 32)
                }

                // テキストと値の部分
                HStack(spacing: 0) {
                    Text(condition.title)
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundStyle(.primary)

                    Spacer()
                    HStack(spacing: 2) {
                        Text(summaryText)
                            .lineLimit(1) // サマリーが長くなりすぎないように制限
                            .foregroundStyle(settings.selectedOptions.isEmpty ? accentColor : .primary)
                            .font(.subheadline)

                        // 展開状態に応じて矢印を回転させる
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(Color.secondary.opacity(0.6))
                            .rotationEffect(.degrees(settings.isOptionsExpanded ? 90 : 0))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)

        // 選択肢リスト (展開時のみ表示)
        if settings.isOptionsExpanded {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(HotpepperOption.allCases, id: \.self) { item in // HotpepperOption.allCases を直接使用

                    let isSelected = settings.selectedOptions.contains(item) // 選択状態のチェック

                    Button {
                        // 選択ロジック: Setに追加/削除 (複数選択)
                        withAnimation(.easeInOut(duration: 0.1)) {
                            if isSelected {
                                settings.selectedOptions.remove(item) // 削除
                            } else {
                                settings.selectedOptions.insert(item) // 追加
                            }
                            // 複数選択なので、選択後に閉じない
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Spacer().frame(width: 40 + 16)

                            Text(item.displayName)
                            Spacer()

                            if isSelected { // チェックマークを表示
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                            }
                            Spacer().frame(width: 10)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundStyle(.primary)
                        .background(isSelected ? Color.gray.opacity(0.1) : Color.clear)
                        .contentShape(Rectangle()) // 行全体をタップ可能に
                    }
                    .buttonStyle(.plain)

                    Divider().padding(.leading, 16 + 40 + 16)
                }
            }
        }
    }
}
