//
//  ContentView.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var selectedTab = Tab.allCases.last!
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                selectedView(tab)
                    .tabItem {
                        Image(systemName: tab.rawValue)
                        Text(tab.title)
                    }
                    .tag(tab.title)
            }
        }
        .environmentObject(viewModel)
    }
    
    @ViewBuilder
    private func selectedView(_ tab: Tab) -> some View {
        if tab.title == "검색" {
            SearchTabView()
                .environmentObject(viewModel)
        } else {
            Text(tab.title)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(SearchViewModel())
    }
}
