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
    
    var id: String { userID }
}

extension UserModel {
    
    var profileColorCalculated: Color {
            guard let hex = profileColorHex else { return .accent }
            return Color(hex: hex)
        }
    
    static let mock = UserModel(
        userID: "mock_user_1",
        dateCreated: .now,
        didCompleteOnboarding: true,
        profileImageURL: nil,
        profileColorHex: "#5AC8FA"
    )

}
