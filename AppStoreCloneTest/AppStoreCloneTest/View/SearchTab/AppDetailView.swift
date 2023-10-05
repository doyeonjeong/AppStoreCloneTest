//
//  AppDetailView.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import SwiftUI

struct AppDetailView: View {
    
    @EnvironmentObject private var viewModel: SearchViewModel
    @State private var expanded: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                baseInformation
                Divider()
                subInformation
                Divider()
                screenshots
                supportedDevices
                Divider()
                discription
            }
        }
        .padding(.horizontal)
    }
    
    private var baseInformation: some View {
        HStack {
            AsyncImage(url: URL(string: viewModel.selectedApp.artworkUrl512)) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    Color.gray
                } else {
                    ProgressView()
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
            .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(viewModel.selectedApp.trackCensoredName)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text(viewModel.selectedApp.artistName)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer()
                
                HStack {
                    Image(systemName: "icloud.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 24)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 24)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 6)
        }
        .padding()
    }
    
    private var subInformation: some View {
        ScrollView {
            HStack {
                subInformationCell(contentType: .age)
                Divider()
                subInformationCell(contentType: .developer)
                Divider()
                subInformationCell(contentType: .language)
            }
        }
    }
    
    private func subInformationCell(contentType: ContentType) -> some View {
        VStack {
            Text(contentType.title)
                .foregroundColor(.gray)
                .font(.subheadline)
            
            contentForType(contentType)
        }
        .frame(maxWidth: 120, maxHeight: 120)
    }
    
    @ViewBuilder
    private func contentForType(_ contentType: ContentType) -> some View {
        switch contentType {
        case .age:
            Text(viewModel.selectedApp.trackContentRating)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            
            Text(contentType.bottomTag)
                .foregroundColor(.gray)
                .font(.subheadline)

        case .developer:
            Image(systemName: contentType.contentImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26)
                .foregroundColor(.gray)
            
            Text(viewModel.selectedApp.artistName)
                .foregroundColor(.gray)
                .font(.subheadline)
                .lineLimit(1)
                .truncationMode(.tail)

        case.language:
            Text(viewModel.selectedApp.languageCodesISO2A[0])
                  .font(.system(size: 28, weight:.bold, design:.rounded))
                  .foregroundColor(.gray)
            let count = viewModel.selectedApp.languageCodesISO2A.count
            let text = count > 2 ? "+ \(count - 1)개 언어" : "\(viewModel.selectedApp.languageCodesISO2A[0])".localized
            Text(text)
                .foregroundColor(.gray)
                .font(.subheadline)
                .lineLimit(1)
                .truncationMode(.tail)

        }
    }
    
    private var screenshots: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<(viewModel.selectedApp.screenshotUrls.count), id: \.self) { i in
                    AsyncImage(url: URL(string: viewModel.selectedApp.screenshotUrls[i])) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            Color.gray
                        } else {
                            ProgressView()
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 400)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
    }
    
    private var supportedDevices: some View {
        HStack {
            Image(systemName: "iphone.gen1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16)
                .foregroundColor(.gray)
            
            Text("iPhone")
                .font(.system(size: 16, weight: .bold ,design: .rounded))
                .foregroundColor(.gray)
        }
        .padding(.leading, 20)
    }
    
    private var discription: some View {
        VStack(alignment: .leading) {
            
            discriptionCell
            
            HStack {
                VStack(alignment: .leading) {
                    Button {
                        // TODO: NavigationLink로 변경 -> 개발자가 만든 앱 정보 push
                    } label: {
                        Text(viewModel.selectedApp.artistName)
                            .font(.body)
                    }
                    .padding(.vertical, 4)
                    
                    Text("개발자")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
            }
        }
        .padding()
    }
    
    private var discriptionCell: some View {
        HStack(alignment: .bottom) {
            if !expanded {
                Text(viewModel.selectedApp.description)
                    .lineLimit(3)
                    .truncationMode(.tail)
                toggleButton
                    .padding(.leading, -60)
            } else {
                Text(viewModel.selectedApp.description)
            }
        }
    }
    
    private var toggleButton: some View {
        ZStack {
            Capsule()
                .foregroundColor(Color(.systemBackground))
                .cornerRadius(5)
                .frame(width: 60, height: 12)
                .shadow(color: Color(.systemBackground), radius: 5, x: 8, y: 8)
            
            Button(action: { expanded.toggle() }) {
                Text("더보기")
            }
        }
    }
}

struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView()
            .environmentObject(SearchViewModel())
    }
}

// MARK: - ContentType
/// subInformation 을 컨텐츠별로 다르게 표시하기 위한 객체
private enum ContentType {
    case age, developer, language
    
    var title: String {
        switch self {
        case .age: return "연령"
        case .developer: return "개발자"
        case .language: return "언어"
        }
    }
    
    var contentImageName: String {
        switch self {
        case .age: return ""
        case .developer: return "person.crop.square"
        case .language: return ""
        }
    }
    
    var bottomTag: String {
        switch self {
        case .age: return "세"
        case .developer: return ""
        case .language: return ""
        }
    }
}
