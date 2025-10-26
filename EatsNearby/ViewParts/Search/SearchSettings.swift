//
//  SearchSettings.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/21.
//
import Foundation
// 選択した条件の状態を保持
class SearchSettings: ObservableObject {
    @Published var keyword: String = ""
    @Published var distance: Double = 1.0
    @Published var locationManager = LocationManager()
    // 検索範囲
    var rangeCode: Int {
        return Int(distance.rounded())
    }
    // MapCircleに渡すための検索範囲（メートル）
    var rangeInMeters: Double {
            switch rangeCode {
            case 1: return 300.0
            case 2: return 500.0
            case 3: return 1000.0
            case 4: return 2000.0
            case 5: return 3000.0
            default: return 1000.0 // デフォルトは1km
            }
        }
    // 選択されたジャンルと予算の状態
    @Published var selectedGenre: HotpepperGenre? = nil
    @Published var selectedBudget: HotpepperBudget? = nil
    // こだわりの条件は複数選択
    @Published var selectedOptions: Set<HotpepperOption> = []
    // 検索ボタンが押された時のフラグ
    @Published var isDirty: Bool = false

    // 展開/折りたたみ状態の管理
    @Published var isGenreExpanded: Bool = false
    @Published var isBudgetExpanded: Bool = false
    @Published var isOptionsExpanded: Bool = false
}
