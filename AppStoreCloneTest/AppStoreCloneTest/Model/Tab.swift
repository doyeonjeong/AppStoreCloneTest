//
//  Tab.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import Foundation

enum Tab: String, CaseIterable {
    case today = "house.fill"
    case games = "gamecontroller.fill"
    case apps = "square.stack.3d.up.fill"
    case updates = "square.and.arrow.down.fill"
    case search = "magnifyingglass"
    
    var title: String {
        switch self {
        case .today: return "투데이"
        case .games: return "게임"
        case .apps: return "앱"
        case .updates: return "업데이트"
        case .search: return "검색"
        }
    }
}
