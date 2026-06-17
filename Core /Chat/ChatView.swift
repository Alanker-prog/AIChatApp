//
//  ChatView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.06.2026.
//

import SwiftUI

struct ChatView: View {

    let chat: ChatModel   // 👈 какой чат открыли
    private let fieldCornerRadius: CGFloat = 30
    private let horizontalPadding: CGFloat = 12

    @State private var chatMessages: [ChatMessageModel] = []
    @State private var textFieldText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(chatMessages) { message in
                        ChatBubbleView(message: message) {
                            onRetryPressed(message)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, horizontalPadding)
            }
            textFieldSection
        }
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadMessages()
        }
    }

    private func loadMessages() {
        // пока фильтруем моки по chatID; позже — запрос к сервису
        chatMessages = ChatMessageModel.mocks.filter { $0.chatID == chat.id }
    }

    private func onRetryPressed(_ message: ChatMessageModel) {
        print("Retry pressed for message: \(message.id)")
        // TODO: подключить реальную переотправку через сервис/ViewModel
    }
    
    private func onSendMessagePressed() {
        let newMessageText = textFieldText.trimmingCharacters(in: .whitespaces)
        guard !newMessageText.isEmpty else { return }
        
      let message = ChatMessageModel(
            id: UUID().uuidString,
            chatID: chat.id,
            authorID: chat.userID,
            content: AIOutput(text: newMessageText, imageURL: nil),
            seenByIDs: [chat.userID],
            createdAt: .now,
            status: .sent
        )
        
        chatMessages.append(message)
        textFieldText = ""
        }
    
    private var textFieldSection: some View {
        TextField("Message", text: $textFieldText, axis: .vertical)
            .lineLimit(1...5)
            .padding(12)
            .padding(.trailing, 40)
            .padding(.leading, 8)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: fieldCornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color(.separator), lineWidth: 1)   // обводка
            }
            .overlay(alignment: .trailing) {
                if !textFieldText.trimmingCharacters(in: .whitespaces).isEmpty {
                    Button {
                        onSendMessagePressed()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                    }
                    .padding(.trailing, 6)
                }
            }
            .padding(.horizontal, horizontalPadding)
    }
}

#Preview {
    NavigationStack {
        ChatView(chat: .mock)
    }
    .preferredColorScheme(.dark)
}
