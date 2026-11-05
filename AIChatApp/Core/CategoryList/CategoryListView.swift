//
//  CategoryListView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 05.11.2026.
//

import SwiftUI

struct CategoryListView: View {
    
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var avatars: [AvatarModel] = []
    @State private var isLoading: Bool = true
    @State private var alert: AnyAppAlert?
    
    let category: AvatarCategory
    
    var body: some View {
        List {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else {
                ForEach(avatars) { avatar in
                    PopularCellView(
                        imageName: avatar.profileImageURL,
                        title: avatar.name,
                        subtitle: avatar.characterDescription
                    )
                }
            }
        }
        .navigationTitle(category.rawValue.capitalized)
        .showCustomAlert(alert: $alert)
        .task {
            await loadAvatars()
        }
    }
    
    private func loadAvatars() async {
        do {
            avatars = try await avatarManager.getAvatars(category: category)
        } catch {
            alert = .init(error: error)
        }
        isLoading = false
    }
}

#Preview {
    NavigationStack { CategoryListView(category: .alien) }
        .environment(AvatarManager.mock)
        .preferredColorScheme(.dark)
}
