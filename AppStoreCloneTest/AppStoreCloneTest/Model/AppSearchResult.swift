//
//  AppSearchResult.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import Foundation

struct AppSearchResult: Decodable {
    let resultCount: Int
    let results: [AppInfo]
}

struct AppInfo: Decodable, Hashable {
    let id: Int
    let censoredName: String // 검열된 앱 이름
    let appDescription: String // 앱 설명
    let appVersion: String
    let releaseNotes: String // 현재 버전 릴리즈 노트 (새로운 소식)
    let mainCategory: String // 앱 메인 카테고리
    let smallIconUrl: String // 작은 앱 아이콘
    let largeIconUrl: String // 큰 앱 아이콘
    let developerName: String // 개발자명
    let screenshotUrls: [String]
    let supportedLanguages: [String] // 지원하는 언어
    let contentRating: String // 지원하는 연령

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case censoredName = "trackCensoredName"
        case appDescription = "description"
        case appVersion = "version"
        case releaseNotes = "currentVersionReleaseDate"
        case mainCategory = "primaryGenreName"
        case smallIconUrl = "artworkUrl60"
        case largeIconUrl = "artworkUrl512"
        case developerName = "artistName"
        case screenshotUrls
        case supportedLanguages = "languageCodesISO2A"
        case contentRating = "trackContentRating"
    }
}

