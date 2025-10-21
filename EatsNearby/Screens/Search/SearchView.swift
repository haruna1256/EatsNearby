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
        GeometryReader { geometry in
            VStack() {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color("accentColor").opacity(0.8))
                        .frame(height: 210)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        .cornerRadius(50)

                    MapView(locationManager: locationManager)
                        .frame( height: 200)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .cornerRadius(50)
                }


                DistanceSliderView(selectedDistance: $distance)
//                SearchListView()
            }
            .background(Image("bgImage"))
        }
    }
}

#Preview {
    SearchView()
}
