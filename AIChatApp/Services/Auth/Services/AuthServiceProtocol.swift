//
//  AuthServiceProtocol.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 08.07.2026.
//

import Foundation

protocol AuthServiceProtocol: Sendable {
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnonymously() async throws -> UserAuthInfo
    func signOut() throws
    func authStateStream() -> AsyncStream<UserAuthInfo?>
}
