//
//  TopPageView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//

import SwiftUI

struct TopPageView: View {
    // LocationManagerは @StateObject として定義
    @StateObject var locationManager = LocationManager()
    var body: some View {
        GeometryReader { geometry in
            // マップとスクロールの縦幅は画面の半分のサイズに
            VStack(spacing: 6) {
                // マップの表示
                MapView()
                    .frame(height: geometry.size.height / 2)

                ScrollView {
                    VStack(spacing: 16) {
                        StoreListView()
                    }
                    .padding(.horizontal, 16) // リスト全体に水平方向の余白
                    .padding(.top, 8)         // 上部に少し余白

                }
                .frame(height: geometry.size.height / 2)
                // ScrollView の背景画像
                .background(
                    Image("bgImage")
                        .resizable()
                )
            }
        }
        // 位置情報の要求を開始
        .onAppear {
            locationManager.requestLocation()
        }
    }
}

#Preview {
    TopPageView()
}
