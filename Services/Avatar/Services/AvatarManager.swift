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
    
    func loadExploreAvatars() async throws {
        async let featured = service.getFeaturedAvatars()
        async let popular = service.getPopularAvatars()
        
        (featuredAvatars, popularAvatars) = try await (featured, popular)
    }
}

#if DEBUG
extension AvatarManager {
    static var mock: AvatarManager {
        AvatarManager(service: MockAvatarService())
    }
}
#endif
