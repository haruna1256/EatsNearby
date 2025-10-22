//
//  Search.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//

import Foundation

protocol SelectableItem: CaseIterable, Hashable {
    var displayName: String { get }
}

// 既存の enum にルールを適用する

extension HotpepperGenre: SelectableItem {}
extension HotpepperBudget: SelectableItem {}


// ジャンル
enum HotpepperGenre: String, CaseIterable {
    case izakaya = "G001"          // 居酒屋
    case diningBar = "G002"        // ダイニングバー・バル
    case creative = "G003"         // 創作料理
    case japanese = "G004"         // 和食
    case western = "G005"          // 洋食
    case italianFrench = "G006"    // イタリアン・フレンチ
    case chinese = "G007"          // 中華
    case yakinikuHormone = "G008"  // 焼肉・ホルモン
    case asian = "G009"            // アジア・エスニック料理
    case international = "G010"    // 各国料理
    case cafeSweets = "G011"       // カフェ・スイーツ
    case bar = "G012"              // バー・カクテル
    case ramen = "G013"            // ラーメン
    case okonomiyaki = "G014"      // お好み焼き・もんじゃ
    case other = "G015"            // その他グルメ

    var displayName: String {
        switch self {
        case .izakaya: "居酒屋"
        case .diningBar: "ダイニングバー・バル"
        case .creative: "創作料理"
        case .japanese: "和食"
        case .western: "洋食"
        case .italianFrench: "イタリアン・フレンチ"
        case .chinese: "中華"
        case .yakinikuHormone: "焼肉・ホルモン"
        case .asian: "アジア・エスニック料理"
        case .international: "各国料理"
        case .cafeSweets: "カフェ・スイーツ"
        case .bar: "バー・カクテル"
        case .ramen: "ラーメン"
        case .okonomiyaki: "お好み焼き・もんじゃ"
        case .other: "その他グルメ"
        }
    }
}

// 予算
enum HotpepperBudget: String, CaseIterable {
    case under2000 = "B001"
    case under3000 = "B002"
    case under4000 = "B003"
    case under5000 = "B008"
    case under7000 = "B004"
    case under10000 = "B005"
    case over10000 = "B006"
    case none = "B009"

    var displayName: String {
        switch self {
        case .under2000: "〜2000円"
        case .under3000: "〜3000円"
        case .under4000: "〜4000円"
        case .under5000: "〜5000円"
        case .under7000: "〜7000円"
        case .under10000: "〜10000円"
        case .over10000: "10000円以上"
        case .none: "指定なし"
        }
    }
}
// 絞り込み（個室・飲み放題など）
enum HotpepperOption: CaseIterable, Hashable {
    case privateRoom
    case freeDrink
    case freeFood
    case card

    var displayName: String {
        switch self {
        case .privateRoom: "個室あり"
        case .freeDrink: "飲み放題あり"
        case .freeFood: "食べ放題あり"
        case .card: "カード利用可"
        }
    }

    var parameterName: String {
        switch self {
        case .privateRoom: "private_room"
        case .freeDrink: "free_drink"
        case .freeFood: "free_food"
        case .card: "card"
        }
    }
}

enum OptionFlag {
    case yes
    case no
}

