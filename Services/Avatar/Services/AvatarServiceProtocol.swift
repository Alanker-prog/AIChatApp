//
//  AvatarServiceProtocol.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.10.2026.
//

import Foundation

protocol AvatarServiceProtocol: Sendable {
    func getFeaturedAvatars() async throws -> [AvatarModel]
    func getPopularAvatars() async throws -> [AvatarModel]
}
