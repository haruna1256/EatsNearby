//
//  TopPageViewModel.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/24.
//
import SwiftUI
import Combine
import CoreLocation
// topPageのデータと状態（お店のリスト、ローディング、エラー）を管理
class TopPageViewModel: ObservableObject {
    @Published var nearbyShops: [Shop] = []         // 近くのお店を入れる配列
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var apiClient: APIClient?
    private var cancellables = Set<AnyCancellable>()

    // 現在地が更新されたことを監視するためのプロパティ
    private var locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager

        do {
            self.apiClient = try APIClient()
        } catch {
            print("APIClientの初期化に失敗: \(error)")
            self.errorMessage = "APIキー設定エラー"
        }

        // LocationManagerの緯度/経度の変更を監視する
        locationManager.$currentLocation
            .compactMap { $0 } // nilではないCLLocationのみを通過させる
            .sink { [weak self] location in
                // 現在地が取得できたら検索を実行
                Task {
                    await self?.fetchNearbyShops(location: location)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    func fetchNearbyShops(location: CLLocation) async {
        guard let client = apiClient else {
            self.errorMessage = "API設定エラーにより検索できません。"
            return
        }

        // 暫定的な検索設定を作成 (範囲1km, キーワードなし)
        let settings = SearchSettings()
        settings.locationManager.latitude = location.coordinate.latitude
        settings.locationManager.longitude = location.coordinate.longitude
        settings.distance = 3.0 // 1000m 検索

        self.isLoading = true
        self.errorMessage = nil

        do {
            // APIClientを呼び出す
            let shops = try await client.searchShops(settings: settings)
            self.nearbyShops = shops
        } catch {
            self.errorMessage = "周辺検索エラー: \(error.localizedDescription)"
            print("Error fetching nearby shops: \(error)")
        }

        self.isLoading = false
    }
}
