//
//  SearchResultListCell.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import SwiftUI

struct SearchResultListCell: View {
    var app: AppInfo
    
    var body: some View {
        VStack {
            baseInformation
            screenshots
        }
    }
    
    @ViewBuilder
    private var baseInformation: some View {
        HStack {
            AsyncImage(url: URL(string: app.smallIconUrl))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(app.censoredName)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text(app.developerName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .padding(.horizontal, 6)
            
            Spacer()
            
            Image(systemName: "icloud.and.arrow.down")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
                .padding()
        }
        .padding()
    }
    
    @ViewBuilder
    private var screenshots: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<app.screenshotUrls.count, id: \.self) { i in
                    AsyncImage(url: URL(string: app.screenshotUrls[i])) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            Color.gray
                        } else {
                            ProgressView()
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 240)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}

struct SearchResultListCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultListCell(app: AppInfo(
            id: 1,
            censoredName: "trackCensoredName",
            appDescription: "Welcome to Relax On :) Relax On is an app where you can create your own relaxing music. Just select three kinds of sounds: Base, Melody, and White Noise, and then you will get a CD for the mixed sounds. While you're creating the music, illustrations for CD covers will be seen being made at the same time. You can control the volume of each sound to get the best mix. Create music, play it, set the timer, and enjoy for your own purpose: better sleep, meditation, study, work, and more.",
            appVersion: "3.0.2",
            releaseNotes: "currentVersionReleaseDate",
            mainCategory: "primaryGenreName",
            smallIconUrl: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/a5/53/46/a553469d-16be-5646-7dc1-99874919811e/AppIcon-0-0-1x_U007emarketing-0-10-0-85-220.png/60x60bb.jpg",
            largeIconUrl: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/a5/53/46/a553469d-16be-5646-7dc1-99874919811e/AppIcon-0-0-1x_U007emarketing-0-10-0-85-220.png/512x512bb.jpg",
            developerName: "artistName",
            screenshotUrls: [],
            supportedLanguages: [],
            contentRating: "4+")
        )
    }
}
