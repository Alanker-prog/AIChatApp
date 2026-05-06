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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    featuredSection
                    categoriesSection
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
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 140)
        }
    }
}

#Preview {
    ExploreView()
}
