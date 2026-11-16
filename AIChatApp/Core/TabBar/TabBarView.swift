//
//  TabBarView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

enum AppTab {
    case explore
    case chats
    case profile
    case myAvatars
}

struct TabBarView: View {
    
    @State private var selection: AppTab = .explore
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Explore", systemImage: "eyes", value: .explore) {
                ExploreView()
            }
            
            Tab("Chats", systemImage: "bubble.left.and.bubble.right.fill", value: .chats) {
                ChatsView()
            }
            
            Tab("myAvatars", systemImage: "person.crop.rectangle.stack", value: .myAvatars) {
                MyAvatarsView()
            }
            
            Tab("Profile", systemImage: "person.fill", value: .profile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    TabBarView()
        .environment(AppState())
        .environment(AuthManager.mockSignedIn)
        .environment(UserManager.mock)
        .environment(AvatarManager.mock)
}
