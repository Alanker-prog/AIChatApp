//
//  AuthManager.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.07.2026.
//

import SwiftUI

@MainActor
@Observable
class AuthManager {

    private let service: AuthServiceProtocol
    private(set) var currentUser: UserAuthInfo?

    init(service: AuthServiceProtocol) {
        self.service = service
    }
    
    private func listenToAuthState() async {
        for await user in service.authStateStream() {
            currentUser = user
            print("Auth state changed! UID: \(user?.uid ?? "nil")")
        }
    }
    
    func startListening() {
        Task {
            await listenToAuthState()
        }
    }
    
    func signInAnonymously() async throws {
        if let user = service.getAuthenticatedUser() {
            currentUser = user
            return
        }
        let user = try await service.signInAnonymously()
        currentUser = user
    }

    func signOut() throws {
        try service.signOut()
    }
    
    func signInAnonymouslyIfNeeded() async throws {
        if service.getAuthenticatedUser() != nil {
            return
        }
        _ = try await service.signInAnonymously()
    }

    // Готовые менеджеры с заданным состоянием для превью/тестов.
    // НЕ использовать в проде — там AuthManager(service: FirebaseAuthService()).
#if DEBUG
    static var mockSignedIn: AuthManager {
        let manager = AuthManager(service: MockAuthService())
        manager.currentUser = .mock(isAnonymous: false)
        return manager
    }

    static var mockAnonymous: AuthManager {
        let manager = AuthManager(service: MockAuthService())
        manager.currentUser = .mock(isAnonymous: true)
        return manager
    }
#endif
}
