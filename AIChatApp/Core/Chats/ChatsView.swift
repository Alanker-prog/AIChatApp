//
//  ChatsView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ChatsView: View {

    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var allAvatars: [AvatarModel] = AvatarModel.mocks
    // TODO: сделать «недавние» наполняемыми — при заходе в чат добавлять аватар собеседника в начало recentAvatars (без дублей, обрезать до ~10)
    @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var path = NavigationPath()   // стек навигации

    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    recentSection
                }
                chatsSection
            }
            .navigationTitle("Chats")
            .listStyle(.plain)
            .navigationDestination(for: ChatModel.self) { chat in
                let avatar = allAvatars.first(where: { $0.id == chat.avatarID }) ?? .mock
                ChatView(chat: chat, avatar: avatar)
            }
            .navigationDestination(for: AvatarModel.self) { avatar in
                AvatarProfileView(avatar: avatar)
            }
        }
    }

    private var recentSection: some View {
            Section("RECENT") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(recentAvatars) { avatar in
                            VStack(spacing: 8) {
                                AvatarView(
                                    imageURL: avatar.profileImageURL,
                                    fallbackText: String(avatar.name.first ?? "?"),
                                    size: 55
                                )
                                Text(avatar.name)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .frame(maxWidth: 60)
                            }
                            .anyButton(.plain) {
                                onAvatarPressed(avatar)
                            }
                        }
                    }
                    .padding(6)
                }
                .listRowInsets(EdgeInsets())
            }
        }

    private var chatsSection: some View {
        ForEach(chats) { chat in
            ChatRowCellViewBuilder(
                currentUserId: chat.userID,
                chat: chat,
                getAvatar: {
                    allAvatars.first(where: { $0.id == chat.avatarID }) ?? .mock
                },
                getLastChatMessage: {
                    return .mock
                }
            )
            .anyButton(.highlight) {
                onChatPressed(chat)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    private func onChatPressed(_ chat: ChatModel) {
        path.append(chat)
    }
    
    private func onAvatarPressed(_ avatar: AvatarModel) {
        // ищем чат с этим аватаром
        if let chat = chats.first(where: { $0.avatarID == avatar.id }) {
            path.append(chat)
        }
        // TODO: если чата нет — создать новый чат с этим аватаром
    }
}

#Preview {
    ChatsView()
        .preferredColorScheme(.dark)
}
