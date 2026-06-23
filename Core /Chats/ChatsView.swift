//
//  ChatsView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ChatsView: View {

    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var path: [ChatModel] = []   // стек навигации

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: chat.userID,
                        chat: chat,
                        getAvatar: {
                            return .mock
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
            .navigationTitle("Chats")
            .listStyle(.plain)
            .navigationDestination(for: ChatModel.self) { chat in
                ChatView(chat: chat, avatar: .mock)
            }
        }
    }

    private func onChatPressed(_ chat: ChatModel) {
        path.append(chat)
    }
}

#Preview {
    ChatsView()
        .preferredColorScheme(.dark)
}
