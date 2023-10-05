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
    let trackId: Int
    /// 검열된 앱 이름
    let trackCensoredName: String
    /// 앱 설명
    let description: String
    let version: String
    /// 현재 버전 릴리즈 노트 (새로운 소식)
    let currentVersionReleaseDate: String
    /// 앱 메인 카테고리
    let primaryGenreName: String
    /// 작은 앱 아이콘
    let artworkUrl60: String
    /// 큰 앱 아이콘
    let artworkUrl512: String
    /// 개발자명
    let artistName: String
    let screenshotUrls: [String]
    /// 지원하는 언어
    let languageCodesISO2A: [String]
    /// 지원하는 연령
    let trackContentRating: String
}
