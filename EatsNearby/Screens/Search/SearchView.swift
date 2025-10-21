//
//  SearchView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//

import SwiftUI
// 検索時に表示される画面
struct SearchView: View {
    @StateObject var locationManager = LocationManager()
    @State var distance: Double = 1.5 // 初期値を設定
    var body: some View {
        VStack() {
            MapView(locationManager: locationManager)
            DistanceSliderView(selectedDistance: $distance)
            SearchListView()
        }
    }
}

#Preview {
    SearchView()
}
