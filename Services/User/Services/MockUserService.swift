//
//  MockUserService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 05.08.2026.
//

import Foundation

actor MockUserService: UserServiceProtocol {
    private var users: [String: UserModel]
    
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
    }
    
    func deleteUser(userID: String) async throws {
        try await Task.sleep(for: .seconds(0.5))
        users[userID] = nil
    }
}
