//
//  SearchView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//

import SwiftUI
// 検索時に表示される画面
struct SearchView: View {
    @StateObject var locationManager = LocationManager()
    @State var distance: Double = 1.5 // 初期値を設定
    var body: some View {
        VStack(spacing: 8) {
            // 現在地のマップの表示、検索範囲によって円の増減できたらいいな
            ZStack {
                Rectangle()
                    .foregroundStyle(Color("accentColor").opacity(0.8))
                    .frame(height: 210)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 15)
                MapView(locationManager: locationManager)
                    .frame( height: 200)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .cornerRadius(80)
            }
            // 検索範囲を指定する
            DistanceSliderView(selectedDistance: $distance)
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
            VStack(spacing: 2) {
                // 選択リストをループで全て表示できるようにする
                ForEach(SearchCondition.allCases) { condition in
                    SearchListView(condition: condition)
                        .padding(.horizontal, 16)
                }
            }
            Spacer()
            Button {
                print("この条件で検索")
            } label: {
                SearchBtnView()
            }


        }
        .background(Image("bgImage"))
    }
}


#Preview {
    SearchView()
}
