//
//  ChatServiceProtocol.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 26.11.2026.
//

import Foundation

protocol ChatServiceProtocol: Sendable {
    func getChats(userID: String) async throws -> [ChatModel]
    func sendMessage(avatarID: String, text: String) async throws
    func streamMessages(chatID: String) -> AsyncThrowingStream<[ChatMessageModel], Error>
}
