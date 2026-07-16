//
//  MockAuthService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.07.2026.
//

import Foundation

struct MockAuthService: AuthServiceProtocol {

    let currentUser: UserAuthInfo?

    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }

    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }

    func signInAnonymously() async throws -> UserAuthInfo {
        UserAuthInfo.mock(isAnonymous: true)
    }

    func signOut() throws {
        // мок: ничего не делаем
    }
}
