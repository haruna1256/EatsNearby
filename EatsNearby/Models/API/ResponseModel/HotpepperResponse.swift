//
//  HotpepperResponse.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/23.
//
import Foundation
// apiからのレスポンスの定義
// お店の情報を取得する
struct HotpepperResponse: Codable {
    let results: Results
}

struct Results: Codable {
    let apiVersion: String?       // APIのバージョン
    let resultsAvailable: Int?    // クエリー条件にマッチする、検索結果の全件数
    let resultsReturned: String?  // このＸＭＬに含まれる検索結果の件数
    let resultsStart: Int?        // 検索結果の開始位置

    // 店舗データの配列
    let shop: [Shop]

    // JSONのキーとプロパティ名を対応させる
    enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
        case resultsAvailable = "results_available"
        case resultsReturned = "results_returned"
        case resultsStart = "results_start"
        case shop
    }
}
