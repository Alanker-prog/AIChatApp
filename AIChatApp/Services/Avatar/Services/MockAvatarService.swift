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
    
    func getAvatars(category: AvatarCategory) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(0.5))
        
        return AvatarModel.mocks.filter { $0.category == category }
    }
    
    func getAvatars(authorID: String) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(0.5))
        
        return AvatarModel.mocks.filter { $0.authorID == authorID }
    }


    func getPopularAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(0.5))
        return AvatarModel.mocks.sorted { $0.clickCount > $1.clickCount } 
    }

    func saveAvatar(_ avatar: AvatarModel) async throws {
        try await Task.sleep(for: .seconds(0.5))
    }
    
    func incrementClickCount(avatarID: String) async throws {
        try await Task.sleep(for: .seconds(0.5))
    }
}
