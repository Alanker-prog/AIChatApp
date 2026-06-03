//
//  UserModels.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 19.05.2026.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable, Codable {
    let userID: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileImageURL: String?
    let profileColorHex: String?
    let displayName: String?

    var id: String { userID }
}

extension UserModel {
    
    var initials: String {
        let source = displayName ?? userID
        let cleaned = source.replacingOccurrences(of: "_", with: " ")
        let parts = cleaned.split(separator: " ").filter { !$0.isEmpty }
        
        guard !parts.isEmpty else { return "?" }
        
        return parts
            .prefix(2)
            .compactMap { $0.first }
            .map { String($0).uppercased() }
            .joined()
    }
    
    var profileColor: Color {
        guard let hex = profileColorHex else { return .accent }
        return Color(hex: hex)
    }
    
    static let mock = UserModel(
        userID: "mock_user_1",
        dateCreated: .now,
        didCompleteOnboarding: true,
        profileImageURL: nil,
        profileColorHex: "#5AC8FA",
        displayName: "Alan Parastaev"
    )
    
}
