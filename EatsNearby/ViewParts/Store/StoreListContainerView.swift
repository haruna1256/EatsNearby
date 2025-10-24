//
//  StoreListContainerView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/24.
//
import SwiftUI
import CoreLocation
// 複数の店舗情報（リスト）を表示するコンテナの役割
struct StoreListContainerView: View {
    // 複数の店舗情報（配列）を受け取る
    let shops: [Shop]
    // LocationManager（現在地を取得するため）を受け取る
    @ObservedObject var locationManager: LocationManager

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("現在地周辺のお店 (\(shops.count)件)")
                .font(.headline)
                .foregroundStyle(Color("accentColor"))
                .padding(.leading, 16)

            if shops.isEmpty {
                Text("周辺にお店が見つかりませんでした。")
                    .foregroundStyle(.secondary)
                    .padding(.leading, 16)
            } else {
                // LocationManagerから現在地の座標を取得
                let userCoordinate = locationManager.currentLocation?.coordinate ?? CLLocationCoordinate2D()

                // 受け取った全てのShopをループで StoreListView に渡す
                ForEach(shops) { shop in
                    StoreListView(
                        shop: shop,
                        userLocation: userCoordinate // 座標を渡す
                    )
                }
            }
        }
    }
}
