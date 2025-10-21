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
    // 選択されたジャンルと予算の状態
    @Published var selectedGenre: HotpepperGenre? = nil
    @Published var selectedBudget: HotpepperBudget? = nil

    // 展開/折りたたみ状態の管理
    @Published var isGenreExpanded: Bool = false
    @Published var isBudgetExpanded: Bool = false
    @Published var isOptionsExpanded: Bool = false
}
