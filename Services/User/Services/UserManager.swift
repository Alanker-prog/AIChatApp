//
//  UserManager.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 12.08.2026.
//

import SwiftUI

@MainActor
@Observable
class UserManager {
    
    private let service: UserServiceProtocol
    private(set) var currentUser: UserModel?
    private var listenerTask: Task<Void, Never>?
    
    init(service: UserServiceProtocol, currentUser: UserModel? = nil) {
        self.service = service
        self.currentUser = currentUser
    }
    
    private func listenToUserState(userID: String) async {
        do {
            for try await user in service.userStateStream(userID: userID) {
                currentUser = user
            }
        } catch {
            print("User stream failed: \(error)")
        }
    }
    
    func startListening(userID: String) {
        listenerTask?.cancel()
        listenerTask = Task {
            await listenToUserState(userID: userID)
        }
    }
    
    func stopListening() {
        listenerTask?.cancel()
        listenerTask = nil
        currentUser = nil
    }
    
    func loadOrCreateUser(auth: UserAuthInfo) async throws {
        if let existingUser = try await service.getUser(userID: auth.uid) {
            currentUser = existingUser
        } else {
            let newUser = UserModel(auth: auth)
            try await service.saveUser(newUser)
            currentUser = newUser
        }
        startListening(userID: auth.uid)
    }
    
    func updateDisplayName(_ newValue: String) async throws {
        guard let user = currentUser else {
            throw UserManagerError.noCurrentUser
        }
        let updatedUser = user.updatingDisplayName(newValue)
        try await service.saveUser(updatedUser)
    }
    
    enum UserManagerError: LocalizedError {
        case noCurrentUser
        var errorDescription: String? {
            switch self {
            case .noCurrentUser: "No signed-in user."
            }
        }
    }
}

#if DEBUG
extension UserManager {
    static var mock: UserManager {
        UserManager(service: MockUserService(), currentUser: .mock)
    }
}
#endif
