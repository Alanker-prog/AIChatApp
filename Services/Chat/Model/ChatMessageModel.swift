//
//  ChatMessageModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 12.05.2026.
//

import Foundation

struct ChatMessageModel: Identifiable, Hashable {
    
    let id: String
    let chatID: String
    let authorID: String?      // nil = сообщение от AI
    let content: AIOutput?
    let seenByIDs: [String]?
    let createdAt: Date
    
    var isAIMessage: Bool {
        authorID == nil
    }
    
    func hasBeenSeenBy(userId: String) -> Bool {
        guard let seenByIDs else { return false }
        return seenByIDs.contains(userId)
    }
}

// MARK: - AIOutput Это контейнер, в котором можно хранить и текст, и изображение одновременно:

struct AIOutput: Hashable {
    let text: String?
    let imageURL: String?
}

// MARK: - Mocks

extension ChatMessageModel {
    
    static let mocks: [ChatMessageModel] = [
        ChatMessageModel(
            id: "mock_message_1",
            chatID: "mock_chat_1",
            authorID: "user_1",          // сообщение от пользователя
            content: AIOutput(
                text: "Hello! Who are you?",
                imageURL: nil
            ),
            seenByIDs: ["user_1"],
            createdAt: .now
        ),
        ChatMessageModel(
            id: "mock_message_2",
            chatID: "mock_chat_1",
            authorID: nil,               // сообщение от AI
            content: AIOutput(
                text: "Hi! I am Alfa, an alien dancing in the space!",
                imageURL: nil
            ),
            seenByIDs: ["user_1"],
            createdAt: .now
        ),
        ChatMessageModel(
            id: "mock_message_3",
            chatID: "mock_chat_1",
            authorID: "user_1",
            content: AIOutput(
                text: "Can you show me a picture?",
                imageURL: nil
            ),
            seenByIDs: ["user_1"],
            createdAt: .now
        ),
        ChatMessageModel(
            id: "mock_message_4",
            chatID: "mock_chat_1",
            authorID: nil,               // AI отвечает картинкой
            content: AIOutput(
                text: nil,
                imageURL: Constants.randomeImage
            ),
            seenByIDs: ["user_1"],
            createdAt: .now
        )
    ]
    
    static let mock: ChatMessageModel = mocks[0]
}
