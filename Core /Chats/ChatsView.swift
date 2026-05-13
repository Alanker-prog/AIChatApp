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
                    Text(chat.id)
                }
            }
                .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
