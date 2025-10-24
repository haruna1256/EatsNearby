//
//  Shop.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/23.
//
import Foundation

// 個々のお店の情報
struct Shop: Codable, Identifiable, Hashable {
    var id: String { idString }

    // 基本情報
    let idString: String            // 店舗ID
    let name: String                // 店舗名
    let nameKana: String?           // 店舗名（かな）
    let address: String?            // 住所
    let tel: String?                // 電話番号
    let lat: Double?                // 緯度
    let lng: Double?                // 経度
    let access: String?             // 交通アクセス
    let mobileAccess: String?       // 携帯用交通アクセス


    // 営業/予約情報
    let open: String?               // 営業時間
    let close: String?              // 定休日
    let party: String?              // 宴会
    let course: String?             // コース
    let freeDrink: String?          // 飲み放題
    let freeFood: String?           // 食べ放題
    let privateRoom: String?        // 個室

    // 詳細情報
    let catchPhrase: String?        // お店キャッチ
    let subGenre: SubGenre?         // お店サブジャンル
    let genre: Genre?               // お店ジャンル
    let budget: BudgetInfo?         // ディナー予算
    let capacity: Int?              // 席数

    // 画像情報
    let logoImage: String?          // ロゴ画像
    let photo: Photo?               // 写真

    // JSONのキーとプロパティ名を対応させる
    enum CodingKeys: String, CodingKey, Hashable {
        case idString = "id"
        case name
        case nameKana = "name_kana"
        case address
        case tel
        case lat
        case lng
        case access
        case mobileAccess = "mobile_access"
        case open
        case close
        case party
        case course
        case freeDrink = "free_drink"
        case freeFood = "free_food"
        case catchPhrase = "catch"
        case subGenre = "sub_genre"
        case genre
        case budget
        case privateRoom
        case capacity
        case logoImage = "logo_image"
        case photo
    }
}
