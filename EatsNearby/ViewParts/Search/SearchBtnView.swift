//
//  SearchBtnView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//

import SwiftUI
// 検索ボタン
struct SearchBtnView: View {
    var body: some View {

            HStack(alignment: .center, spacing: 8) {
                Text("この条件で検索する")
                    .foregroundStyle(Color("bgColor"))
                    .font(.footnote)
                Image("search")
                    .resizable()
                    .frame(width: 34,height: 34)

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color("accentColor").opacity(0.8))
            .cornerRadius(8)
            .frame(height: 72)
            .frame(maxWidth: .infinity)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }





#Preview {
    SearchBtnView()
}
