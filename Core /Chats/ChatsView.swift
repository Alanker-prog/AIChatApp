//
//  ChatsView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [ChatModel] = ChatModel.mocks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: chat.userID,
                        chat: chat,
                        getAvatar: {
                            return.mock
                        },
                        getLastChatMessage: {
                            return.mock
                            
                        }
                    )
                    .anyButton(.highlight) {
                        // action
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .navigationTitle("Chats")
            .listStyle(.plain)
        }
    }
}

#Preview {
    ChatsView()
        .preferredColorScheme(.dark)
}
