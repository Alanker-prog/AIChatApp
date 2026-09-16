//
//  UserServiceProtocol.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 05.08.2026.
//

import Foundation

protocol UserServiceProtocol: Sendable {
    func getUser(userID: String) async throws -> UserModel?
    func saveUser(_ user: UserModel) async throws
    func deleteUser(userID: String) async throws
    func userStateStream(userID: String) -> AsyncThrowingStream<UserModel?, Error>
}
