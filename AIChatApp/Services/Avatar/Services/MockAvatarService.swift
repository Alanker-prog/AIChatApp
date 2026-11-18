//
//  MockAvatarService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.10.2026.
//

import Foundation

struct MockAvatarService: AvatarServiceProtocol {
    
    let avatars: [AvatarModel]
    let delay: Double
    let showError: Bool
    
    init(avatars: [AvatarModel] = AvatarModel.mocks, delay: Double = 0, showError: Bool = false) {
        self.avatars = avatars
        self.delay = delay
        self.showError = showError
    }
    
    enum MockError: Error, LocalizedError {
        case simulatedError
        
        var errorDescription: String? {
            "Simulated error from mock service"
        }
    }
    
    private func simulateRequest() async throws {
        try await Task.sleep(for: .seconds(delay))
        
        if showError {
            throw MockError.simulatedError
        }
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await simulateRequest()
        return avatars
    }
    
    func getAvatars(category: AvatarCategory) async throws -> [AvatarModel] {
        try await simulateRequest()
        
        return avatars.filter { $0.category == category }
    }
    
    func getAvatars(authorID: String) async throws -> [AvatarModel] {
        try await simulateRequest()
        
        return avatars.filter { $0.authorID == authorID }
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await simulateRequest()
        return avatars.sorted { $0.clickCount > $1.clickCount }
    }
    
    func saveAvatar(_ avatar: AvatarModel) async throws {
        try await simulateRequest()
    }
    
    func deleteAvatar(avatarID: String) async throws {
        try await simulateRequest()
    }
    
    func incrementClickCount(avatarID: String) async throws {
        try await simulateRequest()
    }
}
