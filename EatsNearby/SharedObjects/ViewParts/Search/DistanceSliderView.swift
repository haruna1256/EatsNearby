//
//  DistanceSliderView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//
import SwiftUI

// 最大距離を設定するためのカスタムビュー
struct DistanceSliderView: View {
    // 距離 (km) の現在の値と親ビューをバインド
    @Binding var selectedDistance: Double
    // スライダーの最小値、最大値、刻み幅
    let minDistance: Double = 0.1
    let maxDistance: Double = 5.0
    let step: Double = 0.1

    // カテゴリ表示用の色の設定 (例: オレンジ)
    let accentColor = Color.orange

    var body: some View {
        VStack(spacing: 8) {
            // ヘッダー（「検索範囲」と「1km」など）
            HStack {
                Text("検索範囲")
                    .font(.subheadline)
                    .foregroundStyle(.primary)

                Spacer()

                // 現在の距離を小数点なしで表示
                Text(formatDistance(selectedDistance))
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.horizontal, 16)

            // スライダー本体
            Slider(
                value: $selectedDistance,
                in: minDistance...maxDistance,
                step: step
            ) {
                Text("検索範囲を設定")
            }
            .tint(accentColor) // スライダーのバーの色
            .padding(.horizontal, 10) // スライダーは両端にパディングを少なめに設定
        }
        .padding(.vertical, 12)
        .background(Color(.systemBackground)) // 背景色
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 16)
    }
    // 距離をメートルまたはキロメートルでフォーマットする関数
    private func formatDistance(_ distanceKm: Double) -> String {
        let distanceMeters = Int((distanceKm * 1000).rounded())

        if distanceMeters < 1000 {
            // 1km未満の場合はメートルで表示 (例: 100m, 500m)
            return "\(distanceMeters)m"
        } else if distanceMeters == 1000 {
            // 1kmちょうどの場合
            return "1km"
        } else {
            // 1km以上の場合は小数点付きのキロメートルで表示 (例: 1.5km, 5km)
            // DoubleをStringに変換する際に、無駄な小数点を含まないようにする
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            formatter.minimumFractionDigits = distanceKm.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 1

            if let formatted = formatter.string(from: NSNumber(value: distanceKm)) {
                return "\(formatted)km"
            }
            return "\(Int(distanceKm))km"
        }
    }
}


struct DistanceSliderView_Previews: PreviewProvider {
    @State static var distance: Double = 1.5 // 初期値を設定

    static var previews: some View {
        VStack {
            DistanceSliderView(selectedDistance: $distance)
        }
    }
}
