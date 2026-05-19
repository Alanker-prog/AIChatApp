//
//  ChatRowCellViewBuilder.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 15.05.2026.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    
    var currentUserId: String = "1"
    var chat: ChatModel = .mock
    var getAvatar: () async -> AvatarModel?
    var getLastChatMessage: () async -> ChatMessageModel?

    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?

    var body: some View {
        ChatRowCellView(
            imageName: avatar?.profileImageURL,
            headline: avatar?.name,
            subheadline: lastChatMessage?.content?.text,
            hasNewMessage: hasNewChat
        )
        .task {
            avatar = await getAvatar()
        }
        .task {
            lastChatMessage = await getLastChatMessage()
        }
    }
    
    private var hasNewChat: Bool {
        guard let lastChatMessage else { return false }
        return !lastChatMessage.hasBeenSeenBy(userId: currentUserId)
    }
}

#Preview {
    ZStack {
        Color(.systemBackground).ignoresSafeArea()
        
        VStack {
            ChatRowCellViewBuilder(
                chat: .mock,
                getAvatar: { .mock },
                getLastChatMessage: { .mock }
            )
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
