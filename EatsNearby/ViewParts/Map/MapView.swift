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

    /// MapCameraPosition を管理する @State
    @State private var mapPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )

    var body: some View {
        ZStack {
            // Map
            Map(position: $mapPosition, interactionModes: [.all]) {
                // 現在地を青丸で表示
                UserAnnotation()
            }
            .ignoresSafeArea()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        centerMapOnCurrentLocation()
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(12)
                            .background(.regularMaterial)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(20)
                }
            }
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
            // 初期 MapCameraPosition を現在地に設定する
            if let loc = locationManager.currentLocation {
                mapPosition = .region(MKCoordinateRegion(
                    center: loc.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ))
            }
        }
        // currentLocation 更新時にマップ更新（必要なら）
        .onChange(of: locationManager.currentLocation) { newLoc in
            if let loc = newLoc {
                mapPosition = .region(MKCoordinateRegion(
                    center: loc.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ))
            }
        }
    }

    // 現在地に戻る関数
    private func centerMapOnCurrentLocation() {
        guard let loc = locationManager.currentLocation else { return }
        mapPosition = .region(MKCoordinateRegion(
            center: loc.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
}

#Preview {
    MapView()
}
