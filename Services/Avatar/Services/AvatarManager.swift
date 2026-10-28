//
//  AvatarManager.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 12.10.2026.
//

import SwiftUI

@MainActor
@Observable
class AvatarManager {
    
    private let service: AvatarServiceProtocol
    private let imageService: ImageGenerationServiceProtocol
    private(set) var featuredAvatars: [AvatarModel] = []
    private(set) var popularAvatars: [AvatarModel] = []
    
    init(service: AvatarServiceProtocol, imageServiсe: ImageGenerationServiceProtocol) {
        self.service = service
        self.imageService = imageServiсe
    }
    
    func loadExploreAvatars() async throws {
        async let featured = service.getFeaturedAvatars()
        async let popular = service.getPopularAvatars()
        
        (featuredAvatars, popularAvatars) = try await (featured, popular)
    }
    
    func saveAvatar(_ avatar: AvatarModel) async throws {
        try await service.saveAvatar(avatar)
        featuredAvatars.insert(avatar, at: 0)
    }
    
    func generateImage(description: String) async throws -> String {
        return try await imageService.generateImage(description: description)
    }
}

#if DEBUG
extension AvatarManager {
    static var mock: AvatarManager {
        AvatarManager(service: MockAvatarService(), imageServiсe: MockImageGenerationService())
    }
}
#endif
