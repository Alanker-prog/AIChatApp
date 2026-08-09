//
//  UserAuthInfo.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 08.07.2026.
//

import Foundation

struct UserAuthInfo: Sendable {
    let uid: String
    let isAnonymous: Bool
    let email: String?
    let displayName: String?
    let creationDate: Date?
    let lastSignInDate: Date?
}

extension UserAuthInfo {
    static func mock(isAnonymous: Bool = false) -> UserAuthInfo {
        UserAuthInfo(
            uid: "mock_user_123",
            isAnonymous: isAnonymous,
            email: isAnonymous ? nil : "mock@example.com",
            displayName: isAnonymous ? nil : "Mock User",
            creationDate: .now,
            lastSignInDate: .now
        )
    }
}
