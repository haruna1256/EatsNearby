//
//  TopPageView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//

import SwiftUI

struct TopPageView: View {
    // TopPageViewModelをLocationManagerを渡して初期化
    @StateObject private var viewModel: TopPageViewModel
    // LocationManagerは @StateObject として定義
    @StateObject var locationManager = LocationManager()
    // 検索ページに表示するモーダルの状態の管理
    @State private var isShowingSearch = false
    // 検索設定をここで作成し、共有の中心とする
    @StateObject var searchSettings = SearchSettings()
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
        GeometryReader { geometry in
            // マップとスクロールの縦幅は画面の半分のサイズに
            VStack(spacing: 6) {
                // マップの表示
                MapView(locationManager: locationManager)
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
                            StoreListContainerView(shops: viewModel.nearbyShops, locationManager: locationManager)
                        }
                    }
                    .padding(.horizontal, 16) // リスト全体に水平方向の余白
                    .padding(.top, 8)         // 上部に少し余白

                }
                .frame(height: geometry.size.height / 2)
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
                .sheet(isPresented: $isShowingSearch) {
                    SearchView(settings: searchSettings)
                }
            }
            .background(
                Image("bgImage")
                    .resizable()
            )
        }
        // 位置情報の要求
        .onAppear {
            locationManager.requestLocation()
        }
    }
}

#Preview {
    TopPageView()
}
