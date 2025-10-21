//
//  SearchView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//

import SwiftUI
// 検索時に表示される画面
struct SearchView: View {
    @StateObject var settings = SearchSettings()

    var body: some View {
        VStack(spacing: 8) {
            // 現在地のマップの表示、検索範囲によって円の増減できたらいいな
            ZStack {
                Rectangle()
                    .foregroundStyle(Color("accentColor").opacity(0.8))
                    .frame(height: 210)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 15)
                MapView(locationManager: settings.locationManager)
                    .frame( height: 200)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .cornerRadius(80)
            }
            
            // 検索範囲を指定する
            DistanceSliderView(selectedDistance: $settings.distance)
                .padding(.bottom, 8)

            Divider().padding(.horizontal, 16)
            // キーワード検索する
            KeywordSearchView()
            Text("お店の名前、料理名、駅名などで調べられます。")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.leading, 16) // 左端をアイコンと揃える
                .padding(.bottom, 8)
            
            Divider().padding(.horizontal, 16)
            // ジャンルの指定
            SearchConditionCardContent()
            Spacer()
            Button {
                print("この条件で検索")
            } label: {
                SearchBtnView()
            }


        }
        .background(Image("bgImage"))
        .environmentObject(settings) 
    }
}


#Preview {
    SearchView()
}
