//
//  SearchCondition.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import SwiftUI

// 検索画面に表示するリスト項目を定義する enum
enum SearchCondition: CaseIterable, Identifiable {
    // ジャンル、予算、他の条件
    case genre
    case budget
    case options

    var id: String {
        switch self {
        case .genre: "genre"
        case .budget: "budget"
        case .options: "options"
        }
    }

    var title: String {
        switch self {
        case .genre: "ジャンル"
        case .budget: "予算"
        case .options: "こだわり条件"
        }
    }

    var placeholder: String {
        switch self {
        case .genre: "好きなジャンルを選ぶ"
        case .budget: "予算を選択"
        case .options: "条件を選択"
        }
    }

    // 条件のリストのIcon
    var iconName: String {
        switch self {
        case .genre: "dining"
        case .budget: "yen"
        case .options: "people"
        }
    }
}
