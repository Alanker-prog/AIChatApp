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
    private(set) var featuredAvatars: [AvatarModel] = []
    private(set) var popularAvatars: [AvatarModel] = []

    
    init(service: AvatarServiceProtocol) {
        self.service = service
    }
    
    func loadFeaturedAvatars() async throws {
        featuredAvatars = try await service.getFeaturedAvatars()
    }
    
    func loadPopularAvatars() async throws {
        popularAvatars = try await service.getPopularAvatars()
    }
}

#if DEBUG
extension AvatarManager {
    static var mock: AvatarManager {
        AvatarManager(service: MockAvatarService())
    }
}
#endif
