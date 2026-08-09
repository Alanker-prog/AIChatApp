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

    // TODO: реактивность — streamUser(userID:) -> AsyncStream<UserModel?>
    // Firestore имеет готовый async: document.snapshots() (как authStateChanges у Auth)
    // Обернуть в AsyncStream, конвертить snapshot → UserModel через data(as:)
    // Паттерн — как authStateStream в AuthServiceProtocol
}
