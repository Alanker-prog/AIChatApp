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
    let isAnonymous: Bool?
    let email: String?
    let creationDate: Date?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileImageURL: String?
    let profileColorHex: String?
    let displayName: String?

    var id: String { userID }
    
    init(
        userID: String,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileImageURL: String? = nil,
        profileColorHex: String? = nil,
        displayName: String? = nil
    ) {
        self.userID = userID
        self.isAnonymous = isAnonymous
        self.email = email
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileImageURL = profileImageURL
        self.profileColorHex = profileColorHex
        self.displayName = displayName
    }

    init(auth: UserAuthInfo) {
        self.init(
            userID: auth.uid,
            isAnonymous: auth.isAnonymous,
            email: auth.email,
            creationDate: auth.creationDate,
            lastSignInDate: auth.lastSignInDate,
            displayName: auth.displayName
        )
    }
}

extension UserModel {
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case creationDate = "creation_date"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileImageURL = "profile_image_url"
        case profileColorHex = "profile_color_hex"
        case displayName = "display_name"
    }
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
        isAnonymous: true,
        email: nil,
        creationDate: .now,
        lastSignInDate: .now,
        didCompleteOnboarding: true,
        profileImageURL: nil,
        profileColorHex: "#5AC8FA",
        displayName: "Alan Parastaev"
    )
    
}
