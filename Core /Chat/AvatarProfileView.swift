//
//  AvatarProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 24.06.2026.
//

import SwiftUI

struct AvatarProfileView: View {
    
    let avatar: AvatarModel
    
    var body: some View {
        List {
            ImageLoaderView(urlString: avatar.profileImageURL ?? Constants.randomeImage)
                .overlay(alignment: .bottom) {
                    LinearGradient(
                        colors: [.black.opacity(0.6), .clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 150)
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(avatar.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(avatar.description)
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
                .asStretchyHeader(startingHeight: 500)   // Растягивает изображение
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)

            Section("Information") {
                LabeledContent("Name", value: avatar.name)
                LabeledContent("Type", value: avatar.character.option.rawValue)
                LabeledContent("Action", value: avatar.character.action.rawValue)
                LabeledContent("Location", value: avatar.character.location.rawValue)
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        AvatarProfileView(avatar: .mock)
            .preferredColorScheme(.dark)
    }
}
