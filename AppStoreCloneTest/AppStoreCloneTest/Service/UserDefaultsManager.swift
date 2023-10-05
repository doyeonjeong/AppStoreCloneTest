//
//  UserDefaultsManager.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import Foundation

struct UserDefaultsManager {
    private let defaults = UserDefaults.standard
    private let recentKeywordKey = "recentKeyword"
    
    mutating func appendRecentKeyword(_ keyword: String) {
        var keywords: [String] = fetchRecentKeywords()
        if keywords.count >= 10 {
            keywords.remove(at: 0)
        }
        keywords.append(keyword)
        defaults.set(keywords, forKey: recentKeywordKey)
    }
    
    func fetchRecentKeywords() -> [String] {
        return defaults.array(forKey: recentKeywordKey) as? [String] ?? []
    }
}
