//
//  KeywordSearchView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import SwiftUI

// キーワードを入力するview
struct KeywordSearchView: View {
    // キーワード入力の状態管理
    @State private var keyword: String = ""
    var body: some View {
        VStack {
            HStack {
                TextField("キーワード検索", text: $keyword)
                    .keyboardType(.default)
                    .submitLabel(.search)

                // テキストクリアボタン
                if !keyword.isEmpty {
                    Button {
                        keyword = ""
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

#Preview {
    KeywordSearchView()
}
