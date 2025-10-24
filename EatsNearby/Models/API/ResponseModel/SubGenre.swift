//
//  SubGenre.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/23.
//

import Foundation

// サブジャンル
struct SubGenre: Codable, Hashable {
    let name: String?
    let code: String?
}

// ジャンル情報
struct Genre: Codable, Hashable {
    let name: String?
    let code: String?
}

// 予算情報
struct BudgetInfo: Codable, Hashable {
    let name: String?    // 例: "2001〜3000円"
    let code: String?    // 例: "B002"
    let average: String? // 例: "3000円"
}
