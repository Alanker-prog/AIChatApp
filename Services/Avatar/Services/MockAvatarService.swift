//
//  MockAvatarService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.10.2026.
//

import Foundation

struct MockAvatarService: AvatarServiceProtocol {
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(0.5))
        return AvatarModel.mocks
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(0.5))
        return AvatarModel.mocks.shuffled()
    }

    func saveAvatar(_ avatar: AvatarModel) async throws {
        try await Task.sleep(for: .seconds(0.5))
    }
}
