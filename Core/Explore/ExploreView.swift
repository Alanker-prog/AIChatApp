//
//  ExploreView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ExploreView: View {
    
    @Environment(AvatarManager.self) private var avatarManager
    private let categories: [AvatarCategory] = AvatarCategory.allCases
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        featuredSection
                        categoriesSection
                        popularSection
                    }
                }
                .padding()
            }
            .navigationTitle("Explore")
            .task {
                await loadAvatars()
            }
        }
    }
    
    private func loadAvatars() async {
        do {
            try await avatarManager.loadExploreAvatars()
        } catch {
            print("Failed to load avatars: \(error)")
        }
        isLoading = false
    }
    
    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Featured Avatars")
                .font(.title2)
                .bold()
            
            CarouselView(items: avatarManager.featuredAvatars) { avatar in
                HeroCellView(
                    title: avatar.name,
                    subtitle: avatar.characterDescription,
                    imageName: avatar.profileImageURL
                )
                .anyButton(.plain) {
                    
                }
            }
        }
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Categories")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        CategoryCellView(
                            title: category.rawValue.capitalized,
                            imageName: Constants.randomeImage
                        )
                        .anyButton(.plain) {
                            
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 140)
        }
    }
    
    private var popularSection: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Popular")
                .font(.title2.bold())

            VStack(spacing: 8) {

                ForEach(avatarManager.popularAvatars) { avatar in
                    PopularCellView(
                        imageName: avatar.profileImageURL,
                        title: avatar.name,
                        subtitle: avatar.characterDescription
                    )
                    .anyButton(.highlight) {
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
}

#Preview {
    ExploreView()
        .environment(AvatarManager.mock)
}
