//
//  View+Preview.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 19.11.2026.
//
import SwiftUI

#if DEBUG
extension View {
    func previewEnvironment() -> some View {
        self
            .environment(AppState())
            .environment(AuthManager.mockSignedIn)
            .environment(UserManager.mock)
            .environment(AvatarManager.mock)
    }
}
#endif
