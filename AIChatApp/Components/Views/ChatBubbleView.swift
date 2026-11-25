//
//  ChatBubbleView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.06.2026.
//

import SwiftUI

struct ChatBubbleView: View {

    let message: ChatMessageModel
    var onRetryPressed: (() -> Void)?

    var body: some View {
        // Выравнивание зависит от автора: мои сообщения справа, AI — слева.
        HStack(alignment: .bottom, spacing: 4) {
            if !message.isAIMessage {
                Spacer(minLength: 40)   // моё сообщение → толкаем bubble вправо
            }
            
            if message.status == .failed {
                retryButton
            }
                
            bubble
                
            if message.isAIMessage {
                Spacer(minLength: 40)   // сообщение AI → толкаем bubble влево
            }
        }
    }

    // TODO: вёрстка времени — позже втиснуть в строку с текстом (Telegram-стиль)
    private var bubble: some View {
        VStack(alignment: .trailing, spacing: 2) {
            contentView
            
            Text(timeText)
                .font(.caption2)
                .foregroundStyle(textColor.opacity(0.7))
                
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .foregroundStyle(textColor)
        .background(bubbleColor)
        .clipShape(bubbleShape)
    }
    
    private var contentView: some View {
        Text(message.text)
        
    }
    
    private var bubbleColor: Color {
        message.isAIMessage ? Color(.secondarySystemBackground) : .blue
    }
    
    private var textColor: Color {
        message.isAIMessage ? .primary : .white
    }
    
    // TODO: вернуться к хвостику — сейчас простое скругление углов,
    // возможно заменить на кастомную Shape с торчащим уголком (Telegram-стиль)
    private var bubbleShape: UnevenRoundedRectangle {
        let corner: CGFloat = 18
        let tail: CGFloat = 4   // "хвостовой" угол — почти острый

        return UnevenRoundedRectangle(
            topLeadingRadius: corner,
            bottomLeadingRadius: message.isAIMessage ? tail : corner,   // AI: острый низ-слева
            bottomTrailingRadius: message.isAIMessage ? corner : tail,  // моё: острый низ-справа
            topTrailingRadius: corner
        )
    }
    
    private var timeText: String {
        message.createdAt.formatted(date: .omitted, time: .shortened)
    }
    
    private var retryButton: some View {
        Button {
            onRetryPressed?()
        } label: {
            Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.red)
        }
    }
        
}

#Preview {
    VStack(spacing: 12) {
        ChatBubbleView(message: .mocks[0]) // моё: "Hello! Who are you?"
        ChatBubbleView(message: .mocks[1]) // AI: "Hi! I am Alfa..."
        ChatBubbleView(message: .mocks[3]) // AI с картинкой
        
        // проваленное сообщение — показываем кнопку "повторить"
                ChatBubbleView(
                    message: ChatMessageModel(
                        id: "Failed_1",
                        chatID: "",
                        role: .user,
                        text: "Is vessage failed",
                        createdAt: .now,
                        status: .failed
                    )
                       ,
                    onRetryPressed: {
                        print("Retry tapped")
                    }
                )
    }
    .padding()
    .preferredColorScheme(.dark)
}
