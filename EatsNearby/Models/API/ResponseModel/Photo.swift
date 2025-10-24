//
//  Photo.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/23.
//

import Foundation

// 画像情報
struct Photo: Codable, Hashable {
    let mobile: MobilePhoto?
    let pc: PCPhoto?
}

// モバイル画像
struct MobilePhoto: Codable, Hashable {
    let l: String? // 大サイズ
    let s: String? // 小サイズ
}

// PC画像
struct PCPhoto: Codable, Hashable {
    let l: String? // 大サイズ
    let m: String? // 中サイズ
    let s: String? // 小サイズ
}
