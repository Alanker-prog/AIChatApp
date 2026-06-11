//
//  ChatMessageModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 12.05.2026.
//

import Foundation

// MARK: - Message Status

enum MessageStatus: String, Hashable {
    case sending    // уходит на сервер
    case sent       // успешно доставлено
    case failed     // ошибка отправки — показываем "повторить"
}

// MARK: - Chat Message Model

struct ChatMessageModel: Identifiable, Hashable {

    let id: String
    let chatID: String
    let authorID: String?      // nil = сообщение от AI
    let content: AIOutput
    let seenByIDs: [String]?
    let createdAt: Date
    let status: MessageStatus

    var isAIMessage: Bool {
        authorID == nil
    }

    func hasBeenSeenBy(userId: String) -> Bool {
        guard let seenByIDs else { return false }
        return seenByIDs.contains(userId)
    }
}

// MARK: - AIOutput
// Контейнер контента сообщения: может хранить текст, изображение или и то и другое.

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
            createdAt: .now,
            status: .sent
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
            createdAt: .now,
            status: .sent
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
            createdAt: .now,
            status: .sent
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
            createdAt: .now,
            status: .sent
        ),
        // проваленное сообщение — показываем кнопку "повторить"
        ChatMessageModel(
            id: "mock_message_5",
            chatID: "mock_chat_1",
            authorID: "user_1",              // моё сообщение, которое не отправилось
            content: AIOutput(
                text: "This message failed to send",
                imageURL: nil
            ),
            seenByIDs: nil,
            createdAt: .now,
            status: .failed                  // 👈 упавшее
        )
    ]

    static let mock: ChatMessageModel = mocks[0]
}
