//
//  ChatMessageModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 12.05.2026.
//

import Foundation

enum MessageRole: String, Hashable, Codable {
    case user
    case assistant
}

enum MessageStatus: String, Hashable {
    case sending
    case sent
    case failed
}

struct ChatMessageModel: Identifiable, Hashable, Codable {

    let id: String
    let chatID: String
    let role: MessageRole
    let text: String
    let createdAt: Date

    var status: MessageStatus = .sent
    
    var isAIMessage: Bool {
        role == .assistant
    }

}

extension ChatMessageModel {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case chatID = "chat_id"
        case role = "role"
        case text = "text"
        case createdAt = "created_at"
    }
}

extension ChatMessageModel {

    static let mocks: [ChatMessageModel] = [
        ChatMessageModel(
            id: "mock_message_1",
            chatID: "mock_chat_1",
            role: .user,
            text: "Hello have are you?",
            createdAt: .now,
            status: .sending
        ),
        ChatMessageModel(
            id: "mock_message_2",
            chatID: "mock_chat_1",
            role: .assistant,
            text: "Hi! I am Alfa, an alien dancing in the space!",
            createdAt: .now,
            status: .sent
        ),
        ChatMessageModel(
            id: "mock_message_3",
            chatID: "mock_chat_1",
            role: .user,
            text: "Who buid the pyramids?",
            createdAt: .now,
            status: .sending
        ),
        ChatMessageModel(
            id: "mock_message_4",
            chatID: "mock_chat_1",
            role: .assistant,
            text: "The pyramids built by the Egyptians",
            createdAt: .now,
            status: .sent
        ),
        ChatMessageModel(
            id: "mock_message_5",
            chatID: "mock_chat_1",
            role: .user,
            text: "Where is Mount Fuji?",
            createdAt: .now,
            status: .failed
        )
    ]
    
    static let mock: ChatMessageModel = mocks[0]
}
