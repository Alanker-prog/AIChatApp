//
//  ChatModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 11.05.2026.
//

import Foundation

struct ChatModel: Identifiable, Hashable {
    
    let id: String
    let userID: String
    let avatarID: String
    let createdAt: Date
    let updatedAt: Date

    var isNewChat: Bool {
        let diff = Date.now.timeIntervalSince(createdAt)
        return diff < 60 * 60 * 24  // меньше 24 часов
    }
}

// MARK: - Mocks

extension ChatModel {
    
    static let mocks: [ChatModel] = [
        ChatModel(
            id: "mock_chat_1",
            userID: "user_1",
            avatarID: "avatar_1",
            createdAt: .now,
            updatedAt: .now
        ),
        ChatModel(
            id: "mock_chat_2",
            userID: "user_1",
            avatarID: "avatar_2",
            createdAt: .distantPast,
            updatedAt: .now
        ),
        ChatModel(
            id: "mock_chat_3",
            userID: "user_1",
            avatarID: "avatar_3",
            createdAt: .distantPast,
            updatedAt: .distantPast
        ),
        ChatModel(
            id: "mock_chat_4",
            userID: "user_1",
            avatarID: "avatar_4",
            createdAt: .now,
            updatedAt: .now
        )
    ]
    
    static let mock: ChatModel = mocks[0]
}
