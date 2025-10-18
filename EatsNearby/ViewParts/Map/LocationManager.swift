//
//  LocationManager.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/18.
//

import MapKit
import CoreLocation

/// 位置情報の管理＋Map表示に必要な値をSwiftUIに公開する ViewModel
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    /// 現在地
    @Published var currentLocation: CLLocation?

    /// Map表示用のリージョン（最初は東京）
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    /// 位置情報の使用許可リクエスト
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    /// 権限ステータス変更時に呼ばれる
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()  // 1回だけ取得
        default:
            break
        }
    }

    /// 位置情報取得成功時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        currentLocation = location
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )

        manager.stopUpdatingLocation()
    }

    /// 位置情報取得失敗時
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
}
