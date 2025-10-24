//
//  SearchMapView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/24.
//
import MapKit
import SwiftUI
import CoreLocation
// ユーザーの現在地を中心にしたマップを表示し、検索範囲に応じてその中心から円が増減する
struct SearchMapView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var settings: SearchSettings // 検索設定（距離など）

    // マップの中心と表示範囲を管理するState
    @State private var mapPosition: MapCameraPosition
    @State private var currentRegion: MKCoordinateRegion
    // Helper: 距離（メートル）に基づいて適切なズームレベルの span を計算
    private static func zoomSpan(for radius: Double) -> MKCoordinateSpan {
        // 例: 検索範囲の約2倍の幅をマップに表示するための簡単な計算
        let meterPerDegree: Double = 111_000.0 // 緯度1度あたりのメートル数（概算）
        let spanDelta = (radius * 2.5) / meterPerDegree
        // ズームは緯度と経度のデルタを同じにすると綺麗に見えることが多い
        return MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
    }

    public init(locationManager: LocationManager, settings: SearchSettings) {
        self._locationManager = ObservedObject(wrappedValue: locationManager)
        self._settings = ObservedObject(wrappedValue: settings)

        // 初期位置と初期ズームを設定
        let initialCenter = locationManager.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)
        let initialRadius = settings.rangeInMeters // SearchSettingsの初期距離

        let initialRegion = MKCoordinateRegion(
            center: initialCenter,
            span: Self.zoomSpan(for: initialRadius)
        )
        self._mapPosition = State(initialValue: .region(initialRegion))
        self._currentRegion = State(initialValue: initialRegion)
    }

    var body: some View {
        Map(position: $mapPosition, interactionModes: [.all]) {
            // 現在地（青丸）を表示
            UserAnnotation()

            // 検索範囲の円 (MapCircle) を描画
            if let center = locationManager.currentLocation?.coordinate {

                let radiusInMeters = settings.rangeInMeters

                MapCircle(
                    center: center,
                    radius: radiusInMeters // 検索距離を半径として使用 (Double型)
                )
                .stroke(Color.blue.opacity(0.6), lineWidth: 2) // 円の枠線
                .foregroundStyle(Color.blue.opacity(0.1)) // 円の塗りつぶし
            }
        }
        // LocationManagerの現在地が更新されたら、マップの中心を現在地にする
        .onChange(of: locationManager.currentLocation) { newLocation in
            if let loc = newLocation?.coordinate {
                // currentRegion を直接操作
                var newRegion = currentRegion // currentRegion のコピーを作成
                newRegion.center = loc
                currentRegion = newRegion // currentRegion を更新

                // mapPosition も更新
                mapPosition = .region(currentRegion)
            }
        }

        // 検索範囲が変わったときに地図の中心を維持しつつズームを調整
        .onChange(of: settings.rangeInMeters) { newRadius in
            // currentRegion を直接操作
            var newRegion = currentRegion // currentRegion のコピーを作成
            newRegion.span = Self.zoomSpan(for: newRadius)
            currentRegion = newRegion // currentRegion を更新

            // mapPosition も更新
            mapPosition = .region(currentRegion)
        }
    }
}
