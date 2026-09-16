//
//  MockUserService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 05.08.2026.
//

import Foundation

@MainActor
final class MockUserService: UserServiceProtocol {
    
    private var users: [String: UserModel]
    private var continuation: AsyncThrowingStream<UserModel?, Error>.Continuation?
    private var observedUserID: String?
    
    init(users: [UserModel] = []) {
        self.users = Dictionary(uniqueKeysWithValues: users.map { ($0.userID, $0) })
    }
    
    func getUser(userID: String) async throws -> UserModel? {
        try await Task.sleep(for: .seconds(0.5))
        return users[userID]
    }
    
    func saveUser(_ user: UserModel) async throws {
        try await Task.sleep(for: .seconds(0.5))
        users[user.userID] = user
        if observedUserID == user.userID {
            continuation?.yield(user)
        }
    }
    
    func deleteUser(userID: String) async throws {
        try await Task.sleep(for: .seconds(0.5))
        users[userID] = nil
        
        if observedUserID == userID {
            continuation?.yield(nil)
        }
    }
    
    func userStateStream(userID: String) -> AsyncThrowingStream<UserModel?, Error> {
        AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.observedUserID = userID
            continuation.yield(users[userID])
            
            continuation.onTermination = { @Sendable [weak self] _ in
                Task {@MainActor in
                    self?.continuation = nil
                    self?.observedUserID = nil
                }
            }
        }
    }
    
}
