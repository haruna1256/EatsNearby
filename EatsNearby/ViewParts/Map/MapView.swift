//
//  MapView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/18.
//

import SwiftUI
import MapKit
// マップを表示するview
// 現在地を取得してマップに青丸を表示する

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        ZStack {
            // Map
            Map(position: .constant(.region(locationManager.region))) {
                // 現在地を青丸で表示
                UserAnnotation()
            }
            .ignoresSafeArea()

            // 位置取得前のガイド表示（オプション）
            if locationManager.currentLocation == nil {
                VStack {
                    Text("現在地を取得しています…")
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
}

#Preview {
    MapView()
}
