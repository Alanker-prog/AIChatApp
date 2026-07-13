//
//  FirebaseAuthService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 07.07.2026.
//

import Foundation
import FirebaseAuth

struct FirebaseAuthService: AuthServiceProtocol {

    func getAuthenticatedUser() -> UserAuthInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return UserAuthInfo(user: user)   // использует init из +Firebase файла
    }

    func signInAnonymously() async throws -> UserAuthInfo {
        let result = try await Auth.auth().signInAnonymously()
        return UserAuthInfo(user: result.user)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
