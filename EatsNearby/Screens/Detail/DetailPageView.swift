//
//  DetailPageView.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/20.
//

import SwiftUI

struct DetailPageView: View {
    let shop: Shop
    // ルート検索を実行するためのクロージャ
    let onFindRoute: (Shop) -> Void

    @Environment(\.dismiss) var dismiss
    var body: some View {
        DetailView(shop: shop, onFindRoute: { selectedShop in
                    // MapViewにアクションを伝える
                    self.onFindRoute(selectedShop)

                    // 詳細シートを閉じる
                    dismiss() // シートを閉じる
                })
    }
}

struct DetailPageView_Previews: PreviewProvider {
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
        DetailPageView(shop: dummyShop, onFindRoute: { _ in print("Route action triggered in Preview") })
    }
}
