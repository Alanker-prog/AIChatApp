//
//  ChatModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 11.05.2026.
//

import Foundation

struct ChatModel: Identifiable, Hashable, Codable {
    
    let id: String
    let userID: String
    let avatarID: String
    let createdAt: Date
    let updatedAt: Date
    let lastMessageText: String?
}

extension ChatModel {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userID = "user_id"
        case avatarID = "avatar_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastMessageText = "last_message_text"
    }
}

extension ChatModel {
    
    static let mocks: [ChatModel] = [
        ChatModel(
            id: "mock_chat_1",
            userID: "user_1",
            avatarID: "avatar_1",
            createdAt: .now,
            updatedAt: .now,
            lastMessageText: "Hello AI"
        ),
        ChatModel(
            id: "mock_chat_2",
            userID: "user_1",
            avatarID: "avatar_2",
            createdAt: .distantPast,
            updatedAt: .now,
            lastMessageText: nil
        ),
        ChatModel(
            id: "mock_chat_3",
            userID: "user_1",
            avatarID: "avatar_3",
            createdAt: .distantPast,
            updatedAt: .distantPast,
            lastMessageText: "Last message"
        ),
        ChatModel(
            id: "mock_chat_4",
            userID: "user_1",
            avatarID: "avatar_4",
            createdAt: .now,
            updatedAt: .now,
            lastMessageText: nil
        )
    ]
    
    static let mock: ChatModel = mocks[0]
}
