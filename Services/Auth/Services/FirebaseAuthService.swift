//
//  FirebaseAuthService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 07.07.2026.
//

import Foundation
import FirebaseAuth

struct FirebaseAuthService: AuthServiceProtocol {
    
    func authStateStream() -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            let task = Task { @MainActor in
                for await user in Auth.auth().authStateChanges {
                    continuation.yield(user.map(UserAuthInfo.init))
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }

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
