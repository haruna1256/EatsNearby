//
//  TopPageView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//

import SwiftUI
import MapKit

struct TopPageView: View {
    // TopPageViewModelをLocationManagerを渡して初期化
    @StateObject private var viewModel: TopPageViewModel
    // LocationManagerは @StateObject として定義
    @StateObject var locationManager = LocationManager()
    // 検索ページに表示するモーダルの状態の管理
    @State private var isShowingSearch = false
    // 検索設定をここで作成し、共有の中心とする
    @StateObject var searchSettings = SearchSettings()
    // ルート検索結果の状態をここで保持
    @State private var route: MKRoute? = nil
    // ViewModelを初期化
    init() {
        let sharedLocationManager = LocationManager()
        let sharedSearchSettings = SearchSettings()

        // 自身（TopPageView）の @StateObject を初期化
        _locationManager = StateObject(wrappedValue: sharedLocationManager)
        _searchSettings = StateObject(wrappedValue: sharedSearchSettings)

        // ViewModel に両方のオブジェクトを渡して初期化
        _viewModel = StateObject(wrappedValue: TopPageViewModel(
            locationManager: sharedLocationManager,
            searchSettings: sharedSearchSettings
        ))
    }
    var body: some View {
        NavigationStack() {
            VStack(spacing: 0) {
                HeaderView()
                GeometryReader { geometry in
                    // マップとスクロールの縦幅は画面の半分のサイズに
                    VStack(spacing: 6) {
                        // マップの表示
                        MapView(locationManager: locationManager,
                                shops: viewModel.nearbyShops,
                                onFindRoute: { selectedShop in
                            self.findRoute(to: selectedShop)},
                                route: route
                        )
                        .frame(height: geometry.size.height / 2)

                        // 周辺のお店の検索
                        ScrollView {
                            VStack(spacing: 16) {
                                // ロード中、エラー、リストを表示
                                if viewModel.isLoading {
                                    ProgressView("現在地周辺のお店を検索中...")
                                        .padding()
                                } else if let error = viewModel.errorMessage {
                                    Text("\(error)")
                                        .foregroundStyle(Color("accentColor"))
                                        .padding()
                                } else {
                                    StoreListContainerView(
                                        shops: viewModel.nearbyShops,
                                        onFindRoute: { selectedShop in
                                            self.findRoute(to: selectedShop)},
                                        locationManager: locationManager
                                    )
                                    .padding(.bottom, 8)
                                }
                            }
                            .padding(.horizontal, 16) // リスト全体に水平方向の余白
                            .padding(.top, 8)         // 上部に少し余白

                        }
                        .frame(height: geometry.size.height / 2)
                        .sheet(isPresented: $isShowingSearch) {
                            SearchView(settings: searchSettings)
                        }
                    }
                }
                .background(
                    Image("bgImage")
                        .resizable()
                )
                .toolbar(.hidden, for: .navigationBar) // ナビゲーションバーを非表示
                .ignoresSafeArea(.container, edges: [.top, .bottom])
                .overlay(
                    Button(action: {
                        // 検索ページを表示するフラグをONにする
                        isShowingSearch = true
                    }){
                        SearchIconView()
                            .padding()
                            .padding(.trailing, 8)
                    },
                    alignment: .bottomTrailing
                )
            }
        }
        // 位置情報の要求
        .onAppear {
            locationManager.requestLocation()
        }
    }
    // ルート検索を実行する関数
    private func findRoute(to destinationShop: Shop) {
        guard let currentLocation = locationManager.currentLocation?.coordinate,
              let destLat = destinationShop.lat,
              let destLng = destinationShop.lng else {
            self.route = nil
            return
        }

        let sourcePlacemark = MKPlacemark(coordinate: currentLocation)
        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destLat, longitude: destLng))

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .walking
        request.requestsAlternateRoutes = false

        MKDirections(request: request).calculate { response, error in
            guard let route = response?.routes.first else {
                print("ルート検索エラー: \(error?.localizedDescription ?? "ルートが見つかりません")")
                self.route = nil
                return
            }

            // ルートを状態に保存 (MapPolylineに反映される)
            self.route = route
        }
    }
}

#Preview {
    TopPageView()
}
