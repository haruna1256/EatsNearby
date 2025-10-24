//
//  APIClient.swift
//  EatsNearby
//
//  Created by 川岸遥奈 on 2025/10/23.
//
import Foundation
import CoreLocation

// APIクライアントのエラー定義
enum APIClientError: Error {
    case invalidURL
    case apiKeyMissing
    case decodingFailed(Error)
    case networkError(Error)
    case apiError(String)
    case noData

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "無効なURLが生成されました。"
        case .apiKeyMissing: return "APIキーが設定されていません。"
        case .decodingFailed(let error): return "データの解析に失敗しました: \(error.localizedDescription)"
        case .networkError(let error): return "ネットワークエラーが発生しました: \(error.localizedDescription)"
        case .apiError(let message): return "APIエラー: \(message)"
        case .noData: return "データがありません。"
        }
    }
}


class APIClient {

    private let apiKey: String
    private let baseURL = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/"

    // 初期動作
    init() throws {
        // Info.plistからキーを取得し、存在しない場合はエラーをスロー
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
              !key.isEmpty else {
            throw APIClientError.apiKeyMissing
        }
        self.apiKey = key
    }


    // 検索時に実行
    func searchShops(
        settings: SearchSettings
    ) async throws -> [Shop] {

        guard var components = URLComponents(string: baseURL) else {
            throw APIClientError.invalidURL
        }

        var queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "lat", value: String(settings.locationManager.latitude)),
            URLQueryItem(name: "lng", value: String(settings.locationManager.longitude)),
            URLQueryItem(name: "range", value: String(settings.rangeCode)),
            URLQueryItem(name: "format", value: "json")
        ]

        // キーワードがあれば追加
        if !settings.keyword.isEmpty {
            queryItems.append(URLQueryItem(name: "keyword", value: settings.keyword))
        }

        // ジャンル（単一選択）があれば追加
        if let genre = settings.selectedGenre {
            queryItems.append(URLQueryItem(name: "genre", value: genre.parameterName))
        }

        // 予算（単一選択）があれば追加
        if let budget = settings.selectedBudget {
            queryItems.append(URLQueryItem(name: "budget", value: budget.parameterName))
        }

        // こだわり条件（複数選択）があれば追加
        if !settings.selectedOptions.isEmpty {
            let optionsString = settings.selectedOptions.map { $0.parameterName }.joined(separator: ",")
            queryItems.append(URLQueryItem(name: "special_option", value: optionsString)) // special_option はダミー。適切なAPIパラメータ名に修正してください。
        }

        components.queryItems = queryItems
        guard let url = components.url else { throw APIClientError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIClientError.networkError(NSError(domain: "HTTP", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil))
        }

        do {
            let decodedResponse = try JSONDecoder().decode(HotpepperResponse.self, from: data)

            // APIからのエラーチェック（例：エラーメッセージがresults内にある場合）
             if let errorMessage = decodedResponse.results.errorText {
                 throw APIClientError.apiError(errorMessage)
             }

            return decodedResponse.results.shop
        } catch let decodingError {
            throw APIClientError.decodingFailed(decodingError)
        }
    }
}

