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
    
    private var searchSettings: SearchSettings
    // 現在地が更新されたことを監視するためのプロパティ
    private var locationManager: LocationManager
    
    init(locationManager: LocationManager, searchSettings: SearchSettings) {
        self.locationManager = locationManager
        self.searchSettings = searchSettings
        
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
                    await self?.fetchNearbyShops(location: location, settings: self!.searchSettings)
                }
            }
            .store(in: &cancellables)
        // SearchSettings の isDirty フラグを監視
        searchSettings.$isDirty
            .filter { $0 == true } // true になったときだけ処理
            .sink { [weak self] _ in
                // フラグをリセットしてから検索実行
                searchSettings.isDirty = false
                
                // 現在地が利用可能なら、その座標と新しい設定で検索
                if let location = locationManager.currentLocation {
                    Task {
                        await self?.fetchNearbyShops(location: location, settings: self!.searchSettings)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchNearbyShops(location: CLLocation, settings: SearchSettings) async {
        guard let client = apiClient else {
            self.errorMessage = "API設定エラーにより検索できません。"
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            // APIClientを呼び出す (settingsの内容が全て反映される)
            let shops = try await client.searchShops(settings: settings)
            self.nearbyShops = shops
        } catch {
            self.errorMessage = "検索エラー: \(error.localizedDescription)"
            print("Error fetching shops: \(error)")
        }
        
        self.isLoading = false
    }
}
