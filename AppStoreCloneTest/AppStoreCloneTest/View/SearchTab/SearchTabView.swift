//
//  SearchTabView.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import SwiftUI

struct SearchTabView: View {
    
    @EnvironmentObject private var viewModel: SearchViewModel
    @State private var showResult: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if !viewModel.isSearching {
                    Text("최근 검색어")
                        .font(.title3)
                        .bold()
                    
                    ForEach(viewModel.recentResults(), id: \.self) { recent in
                        Text("\(recent)")
                            .onTapGesture {
                                viewModel.searchText = recent
                                showResult = true
                            }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onChange(of: viewModel.searchText, perform: { newValue in
                viewModel.loadResult(keyword: newValue)
            })
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "App Store"
            ) {
                ForEach(viewModel.filteredResults, id: \.id) { info in
                    HStack {
                        Text(info.censoredName)
                            .searchCompletion(info.censoredName)
                    }
                }
            }
            .autocorrectionDisabled()
            .onSubmit(of: .search) {
                showResult = true
                viewModel.addRecent()
            }
            .navigationDestination(isPresented: $showResult, destination: {
                SearchResultListView()
            })
            
            .navigationTitle("검색")
            .onAppear {
                viewModel.searchText = ""
            }
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
            .environmentObject(SearchViewModel())
    }
}
