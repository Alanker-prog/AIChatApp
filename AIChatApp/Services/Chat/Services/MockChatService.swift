//
//  MockChatService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 26.11.2026.
//

import Foundation

@MainActor
final class MockChatService: ChatServiceProtocol {
    
    private let chats: [ChatModel]
    private var messages: [ChatMessageModel]
    private var continuation: AsyncThrowingStream<[ChatMessageModel], Error>.Continuation?
    private var observedChatID: String?
    private let delay: Double
    private let showError: Bool

    init(chats: [ChatModel] = ChatModel.mocks, messages: [ChatMessageModel] = ChatMessageModel.mocks, delay: Double = 0, showError: Bool = false) {
        self.chats = chats
        self.messages = messages
        self.delay = delay
        self.showError = showError
    }
    
    enum MockError: LocalizedError {
        case simulatedError
        
        var errorDescription: String? {
            "Simulated error from mock service"
        }
    }
    
    private func simulateRequest() async throws {
        try await Task.sleep(for: .seconds(delay))
        
        if showError {
            throw MockError.simulatedError
        }
    }
    
    func getChats(userID: String) async throws -> [ChatModel] {
        try await simulateRequest()
        
        return chats
            .filter { $0.userID == userID }
            .sorted { $0.updatedAt > $1.updatedAt }
    }
    
    func sendMessage(avatarID: String, text: String) async throws {
        try await simulateRequest()
        
        let chatID = chats.first { $0.avatarID == avatarID }?.id ?? "mock_chat_new"
        
        let userMessage = ChatMessageModel(
            id: UUID().uuidString,
            chatID: chatID,
            role: .user,
            text: text,
            createdAt: .now
        )
        let assistantMessage = ChatMessageModel(
            id: UUID().uuidString,
            chatID: chatID,
            role: .assistant,
            text: "Mock reply to: \(text)",
            createdAt: .now
        )
        
        messages.append(contentsOf: [userMessage, assistantMessage])
        
        if observedChatID == chatID {
            continuation?.yield(messages.filter { $0.chatID == chatID })
        }
    }
    
    func streamMessages(chatID: String) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.observedChatID = chatID
            continuation.yield(messages.filter { $0.chatID == chatID })
            
            continuation.onTermination = { @Sendable [weak self] _ in
                Task {@MainActor in
                    self?.continuation = nil
                    self?.observedChatID = nil
                }
            }
        }
    }
}
