//
//  StoreListView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/19.
//

import SwiftUI
import CoreLocation

struct StoreListView: View {
    // 店の情報を受け取る変数
    let shop: Shop
    // ユーザーの現在地を受け取る
    let userLocation: CLLocationCoordinate2D

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Rectangle()
                    .frame(width: 72, height: 64)
                    .background(Color("accentSubColor"))

                AsyncImage(url: URL(string: shop.logoImage ?? shop.photo?.pc?.l ?? "")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image("placeholder_store") // プレースホルダー画像
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 72, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            VStack(alignment: .leading) {
                Text(shop.name)
                    .font(.subheadline)
                HStack(spacing: 0) {
                    Text(shop.access ?? shop.address ?? "情報なし")
                        .font(.caption2)
                        .lineLimit(1)
                    Spacer()
                    Text(distanceText(from: shop))
                        .font(.caption)
                        .frame(maxHeight: .infinity, alignment: .bottom)

                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color("bgColor"))
        .cornerRadius(8)
        .shadow(color: Color("accentColor").opacity(0.1), radius: 3, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .frame(height: 72)
    }

    // 現在地からの距離を計算・整形するヘルパー関数
    private func distanceText(from shop: Shop) -> String {
        guard let lat = shop.lat, let lng = shop.lng else {
            return "-"
        }
        let shopLocation = CLLocation(latitude: lat, longitude: lng)
        let userLocationCL = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)

        let distanceInMeters = userLocationCL.distance(from: shopLocation)

        // 距離を適切な単位に変換
        let formatter = LengthFormatter()
        formatter.unitStyle = .short

        if distanceInMeters < 1000 {
            // 1000m未満はメートルで表示
            return formatter.string(fromValue: distanceInMeters, unit: .meter)
        } else {
            // 1000m以上はキロメートルで表示
            let distanceInKilometers = distanceInMeters / 1000
            return formatter.string(fromValue: distanceInKilometers, unit: .kilometer)
        }
    }
}
