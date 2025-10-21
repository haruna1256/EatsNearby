//
//  DitailView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//
import SwiftUI

struct DitailView: View {
    // 仮データ
    let shopName = "居酒屋 ホットペッパー"
    let genreName = "居酒屋"
    let genreCatch = "一口餃子専門店"
    let address = "東京都渋谷区恵比寿1-1-1ABCビル1F"
    let open = "月-金: 11:30-15:00, 17:30-23:00\n土日祝: 11:30-23:00"
    let average = "「900円」「フリー2500円　宴会3500円」"
    let phoneNumber = "03-1234-5678"
    let imageUrl = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?fit=crop&w=800&q=80"
    let free_drink = "あり"
    let free_food = "あり"
    let private_room = "あり"
    let capacity = "300"

    // 情報項目を整形するためのヘルパービュー
    private func DetailRow(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 4) {
            // ラベル（項目名）
            Text(label)
                .font(.footnote)
                .foregroundStyle(Color("accentColor").opacity(0.8))
                .frame(width: 60, alignment: .leading)

            // 値
            Text(value)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Image("bgImage")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .ignoresSafeArea()

            // 詳細の内容はスクロールできるようにする
            // 画像は画面の半分のサイズに
                ScrollView {
                    VStack(spacing: 0) {
                        AsyncImage(url: URL(string: imageUrl)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            default:
                                Color.gray.opacity(0.2) // ロード中または失敗時のプレースホルダー
                            }
                        }
                        .clipped()
                    }
                    .frame(height: geometry.size.height / 2)


                    // テキスト群が入る想定の領域
                    VStack(alignment: .leading, spacing: 20) {
                        // タイトルとジャンル
                        VStack(alignment: .leading, spacing: 4) {
                            Text(shopName)
                                .font(.title2).bold()
                                .foregroundStyle(Color("textColor"))

                            HStack() {
                                Text(genreName)
                                    .font(.callout)
                                    .foregroundStyle(Color("accentColor").opacity(0.8))
                                Text(genreCatch)
                                    .font(.callout)
                                    .foregroundStyle(Color("accentColor").opacity(0.8))
                            }

                        }
                        .padding(.top, 16)

                        // 詳細情報セクション (DetailRowを使用し、項目を揃える)
                        VStack(alignment: .leading, spacing: 10) {
                            DetailRow(label: "住所", value: address)
                            DetailRow(label: "営業時間", value: open)
                            DetailRow(label: "電話番号", value: phoneNumber)
                            DetailRow(label: "平均予算", value: average)
                            HStack(spacing: 10) {
                                DetailRow(label: "飲み放題", value: free_drink)
                                DetailRow(label: "食べ放題", value: free_food)
                            }
                            DetailRow(label: "個室", value: private_room)
                            DetailRow(label: "総席数", value: "\(capacity)席")
                        }
                        Spacer().frame(height: 20)
                    }
                    .frame(maxWidth: .infinity)

                    VStack {
                        HStack(spacing: 12) {
                            // 地図を見る/電話をかける ボタン
                            HStack(spacing: 16) {

                                // 地図を見るボタン
                                ActionButton(iconName: "map", label: "ルートを検索", action: { print("地図へ") })

                                // 電話をかけるボタン
                                ActionButton(iconName: "phone.fill", label: "電話をかける", action: { print("電話をかける") })
                            }

                            // 予約するボタン（メインアクション）
                            Button(action: {
                                print("予約する")
                            }) {
                                Text("予約する")
                                    .font(.headline).bold()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color("accentColor"))
                                    .foregroundStyle(.white)
                                    .cornerRadius(8)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

// 補助的なボタン構造体
struct ActionButton: View {
    let iconName: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.title3)
                Text(label)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundStyle(Color("accentColor"))
            .cornerRadius(8)
        }
    }
}

#Preview {
    DitailView()
}
