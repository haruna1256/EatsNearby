//
//  KeywordSearchView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import SwiftUI

// キーワードを入力するview
struct KeywordSearchView: View {
    @ObservedObject var settings: SearchSettings

    var body: some View {
        VStack {
            HStack {
                TextField("キーワード検索", text: $settings.keyword)
                    .keyboardType(.default)
                    .submitLabel(.search)

                // テキストクリアボタン
                if !settings.keyword.isEmpty {
                    Button {
                        settings.keyword = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color("accentColor").opacity(0.8))
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Color("bgColor"))
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)

    }
}

struct KeywordSearchView_Previews: PreviewProvider {
    // プレビュー用にダミーの SearchSettings インスタンスを作成
    static var dummySettings: SearchSettings = {
        let settings = SearchSettings()
        settings.keyword = "ラーメン" // プレビュー用の初期値を設定
        return settings
    }()

    static var previews: some View {
        KeywordSearchView(settings: dummySettings)
            .previewLayout(.sizeThatFits)
    }
}

