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
    
    init(service: UserServiceProtocol, currentUser: UserModel? = nil) {
        self.service = service
        self.currentUser = currentUser
    }
    
    func loadOrCreateUser(auth: UserAuthInfo) async throws {
        if let existingUser = try await service.getUser(userID: auth.uid) {
            currentUser = existingUser
        } else {
            let newUser = UserModel(auth: auth)
            try await service.saveUser(newUser)
            currentUser = newUser
        }
    }
}
