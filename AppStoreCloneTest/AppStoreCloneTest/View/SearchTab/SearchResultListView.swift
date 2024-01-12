//
//  SearchResultListView.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import SwiftUI

struct SearchResultListView: View {
    
    @EnvironmentObject private var viewModel: SearchViewModel
    @State private var showDetail: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.searchResults, id: \.id) { app in
                        SearchResultListCell(app: app)
                        .onTapGesture {
                            viewModel.selectedApp = app
                            showDetail = true
                        }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .autocorrectionDisabled()
        .onDisappear {
            UIApplication.shared.endEditing()
        }
        .navigationDestination(isPresented: $showDetail, destination: {
            AppDetailView()
        })
    }
}

struct SearchResultListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultListView()
            .environmentObject(SearchViewModel())
    }
}
