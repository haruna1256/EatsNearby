//
//  DetailView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//
import SwiftUI

struct DetailView: View {
    // お店の情報を受け取る
    let shop: Shop
    // ルート検索を実行するためのクロージャ
    let onFindRoute: (Shop) -> Void
    // 適切な画像URLを選択する計算プロパティ
    var shopImageUrl: String? {
        // photo.pc.l, photo.mobile.l, logoImage の順に優先
        return shop.photo?.pc?.l ?? shop.photo?.mobile?.l ?? shop.logoImage
    }

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
                        AsyncImage(url: URL(string: shopImageUrl ?? "")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width, height: 400)
                                    .clipped()
                            default:
                                Color.gray.opacity(0.2) // ロード中または失敗時のプレースホルダー
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(height: geometry.size.height / 2)


                    // テキスト群が入る想定の領域
                    VStack(alignment: .leading, spacing: 20) {
                        // タイトルとジャンル
                        VStack(alignment: .leading, spacing: 4) {
                            Text(shop.name)
                                .font(.title2).bold()
                                .foregroundStyle(Color("textColor"))


                            Text(shop.genre?.name ?? "")
                                .font(.callout)
                                .foregroundStyle(Color("accentColor").opacity(0.8))
                            Text(shop.catchPhrase ?? "キャッチフレーズなし")
                                .font(.callout)
                                .foregroundStyle(Color("accentColor").opacity(0.8))


                        }
                        .padding(.top, 16)

                        // 詳細情報セクション (DetailRowを使用し、項目を揃える)
                        VStack(alignment: .leading, spacing: 10) {
                            DetailRow(label: "住所", value: shop.address ?? "情報なし")
                            DetailRow(label: "営業時間", value: shop.open ?? "情報なし")
                            DetailRow(label: "電話番号", value: shop.tel ?? "情報なし")
                            DetailRow(label: "平均予算", value: shop.budget?.average ?? "情報なし")
                            HStack(spacing: 10) {
                                DetailRow(label: "飲み放題", value: shop.freeDrink ?? "なし")
                                DetailRow(label: "食べ放題", value: shop.freeFood ?? "なし")
                            }
                            DetailRow(label: "個室", value: shop.privateRoom ?? "なし")
                            DetailRow(label: "総席数", value: shop.capacity.map { "\($0)席" } ?? "情報なし")
                        }
                        Spacer().frame(height: 20)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    HStack(spacing: 12) {
                        // 地図を見る/電話をかける ボタン
                        HStack(spacing: 16) {

                            // 地図を見るボタン
                            ActionButton(iconName: "map", label: "ルートを検索", action: {  onFindRoute(shop) })

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
                    .padding(.bottom, 80)
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyShop = Shop(
            idString: "J0012345",
            name: "居酒屋 ホットペッパー",
            nameKana: "いざかや",
            address: "東京都渋谷区恵比寿1-1-1ABCビル1F",
            tel: "03-1234-5678",
            lat: 35.6454, lng: 139.7135,
            access: "恵比寿駅から徒歩3分", mobileAccess: nil,
            open: "月-金: 11:30-15:00, 17:30-23:00 / 土日祝: 11:30-23:00",
            close: "年中無休", party: "3,000円〜", course: "あり",
            freeDrink: "あり", freeFood: "なし",
            privateRoom: "あり", // Shop モデルが privateRoom を持っていると仮定
            catchPhrase: "一口餃子専門店",
            subGenre: nil,
            genre: Genre(name: "居酒屋", code: "G001"),
            budget: BudgetInfo(name: "3001〜4000円", code: "B003", average: "3,000円"),
            capacity: 30,
            logoImage: nil,
            photo: Photo(
                mobile: MobilePhoto(l: nil, s: nil),
                pc: PCPhoto(l: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?fit=crop&w=800&q=80", m: nil, s: nil)
            )
        )
        DetailView(shop: dummyShop, onFindRoute: { _ in print("Route action triggered in Preview") })
    }
}
