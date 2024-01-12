//
//  SearchViewModel.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    
    var userDefaultsManager = UserDefaultsManager()
    let network = NetworkService(configuration: .default)
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    /// 선택된 앱 정보
    @Published var selectedApp: AppInfo = AppInfo()
    
    /// API로부터 받아온 원본 검색 결과 리스트
    @Published var searchResults: [AppInfo] = []
    
    /// 사용자가 입력한 검색 텍스트에 따라 필터링된 결과 리스트
    @Published var filteredResults: [AppInfo] = []
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    init() {
        addSubscribers() // 초기화 시점에 구독 시작
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    /// 구독을 처리하는 메서드
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main) // 사용자가 타이핑을 멈춘 후 필터링 시작
            .sink { [weak self] searchText in
                self?.filterResults(searchText: searchText) // 입력된 검색 텍스트에 따라 결과를 필터링
            }
            .store(in: &subscriptions)
    }
    
    private func filterResults(searchText: String) {
        guard !searchText.isEmpty else {
            filteredResults = []
            return
        }
        
        let search = searchText.lowercased()
        
        filteredResults = searchResults.filter { app in
            let artistNameContainsSearch = app.developerName.lowercased().contains(search)
            return artistNameContainsSearch
        }
    }
    
    func addRecent() {
        userDefaultsManager.appendRecentKeyword(searchText)
    }
    
    func recentResults() -> [String] {
        return userDefaultsManager.fetchRecentKeywords()
    }
    
    func loadResult(keyword: String) {
        let resource = Resource<AppSearchResult>(
            base: "https://itunes.apple.com/",
            path: "search",
            params:["term": keyword, "entity": "software"]
        )
        
        network.load(resource)
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.searchResults, on: self)
            .store(in: &subscriptions)
        
    }
}
