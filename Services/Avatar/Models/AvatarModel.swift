//
//  AvatarModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.04.2026.
//

import Foundation

struct AvatarModel: Identifiable, Hashable {
    
    let id: String
    let name: String
    let category: AvatarCategory
    let profileImageURL: String?
    let authorID: String
    let createdAt: Date
    let characterDescription: String
}


// MARK: - Enums

enum AvatarCategory: String, Hashable, CaseIterable {
    case man
    case woman
    case alien
    case dog
    case cat
}


// MARK: - Mocks

extension AvatarModel {
    
    static let mocks: [AvatarModel] = [
        AvatarModel(
            id: "avatar_1",
            name: "Alfa",
            category: .alien,
            profileImageURL: Constants.randomeImage,
            authorID: "user_1",
            createdAt: .now,
            characterDescription: "A green alien dancing among the stars"
        ),
        AvatarModel(
            id: "avatar_2",
            name: "Beta",
            category: .dog,
            profileImageURL: Constants.randomeImage,
            authorID: "user_2",
            createdAt: .now,
            characterDescription: "A dog is running and barking in the yard"
        ),
        AvatarModel(
            id: "avatar_3",
            name: "Gamma",
            category: .cat,
            profileImageURL: Constants.randomeImage,
            authorID: "user_3",
            createdAt: .now,
            characterDescription: "A cat sleeps in the sun in the garden"
        ),
        AvatarModel(
            id: "avatar_4",
            name: "Delta",
            category: .woman,
            profileImageURL: Constants.randomeImage,
            authorID: "user_4",
            createdAt: .now,
            characterDescription: "A woman eats chocolate ice cream in a park"
        )
    ]
    
    static let mock: AvatarModel = mocks[0]
}
