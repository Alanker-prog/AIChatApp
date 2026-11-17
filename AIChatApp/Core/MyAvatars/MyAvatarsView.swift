//
//  MyAvatarsView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.11.2026.
//

import SwiftUI

struct MyAvatarsView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var showCreateAvatar: Bool = false
    @State private var avatars: [AvatarModel] = []
    @State private var isLoading: Bool = true
    @State private var selectedAvatar: AvatarModel?
    @State private var alert: AnyAppAlert?
    
    var body: some View {
        NavigationStack {
            List {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else if avatars.isEmpty {
                    ContentUnavailableView {
                        Label("No avatars yet", systemImage: "person.crop.circle.badge.plus")
                    } description: {
                        Text("Create your first avatar")
                    } actions: {
                        Button("Create avatar") {
                            showCreateAvatar = true
                        }
                    }
                } else {
                    ForEach(avatars) { avatar in
                        PopularCellView(
                            imageName: avatar.profileImageURL,
                            title: avatar.name,
                            subtitle: avatar.characterDescription
                        )
                        .anyButton {
                            selectedAvatar = avatar
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                onDeletePressed(avatar)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Avatars")
            .showCustomAlert(alert: $alert)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateAvatar = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .navigationDestination(item: $selectedAvatar, destination: { avatar in
                AvatarProfileView(avatar: avatar)
            })
            .sheet(isPresented: $showCreateAvatar, onDismiss: {
                Task { await loadAvatars() }
            }, content: {
                CreateAvatarView()
            })
            .task {
                await loadAvatars()
            }
        }
    }
    
    private func loadAvatars() async {
        defer { isLoading = false }
        guard let uid = authManager.currentUser?.uid else { return }
        do {
            avatars = try await avatarManager.getAvatars(authorID: uid)
        } catch {
            alert = .init(error: error)
        }
    }
    
    private func onDeletePressed(_ avatar: AvatarModel) {
        Task {
            do {
                try await avatarManager.deleteAvatar(avatarID: avatar.id)
                avatars.removeAll { $0.id == avatar.id }
            } catch {
                alert = .init(error: error)
            }
        }
    }
}

#Preview("With avatars") {
    MyAvatarsView()
        .environment(AuthManager.mockSignedIn)
        .environment(AvatarManager.mock)
}
#Preview("Empty") {
    MyAvatarsView()
        .environment(AuthManager.mockSignedIn)
        .environment(AvatarManager(service: MockAvatarService(avatars: []), imageService: MockImageGenerationService()))
}
