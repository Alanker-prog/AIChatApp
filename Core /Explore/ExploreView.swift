//
//  ExploreView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popularAvatars: [AvatarModel] = AvatarModel.mocks
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    featuredSection
                    categoriesSection
                    popularSection
                }
                .padding()
            }
            .navigationTitle("Explore")
        }
        
    }
    
    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Futured Avatar")
                .font(.title2)
                .bold()
            
            CarouselView(items: featuredAvatars) { avatar in
                HeroCellView(
                    title: avatar.name,
                    subtitle: avatar.description,
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
                            imageName: Constants.randomeImage,
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

                ForEach(featuredAvatars) { avatar in
                    PopularCellView(
                        imageName: avatar.profileImageURL,
                        title: avatar.name,
                        subtitle: avatar.description
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
}
