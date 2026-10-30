//
//  AvatarModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.04.2026.
//

import Foundation

struct AvatarModel: Identifiable, Hashable, Codable {
    
    let id: String
    let name: String
    let category: AvatarCategory
    let profileImageURL: String?
    let authorID: String
    let createdAt: Date
    let characterDescription: String
}

enum AvatarCategory: String, Hashable, CaseIterable, Codable {
    case man
    case woman
    case alien
    case dog
    case cat
}

extension AvatarModel {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case category = "category"
        case profileImageURL = "profile_image_url"
        case authorID = "author_id"
        case createdAt = "created_at"
        case characterDescription = "character_description"
    }
}

extension AvatarModel {
    
    static let mocks: [AvatarModel] = [
        AvatarModel(
            id: "avatar_1",
            name: "Alfa",
            category: .alien,
            profileImageURL: Constants.randomImage,
            authorID: "user_1",
            createdAt: .now,
            characterDescription: "A green alien dancing among the stars"
        ),
        AvatarModel(
            id: "avatar_2",
            name: "Beta",
            category: .dog,
            profileImageURL: Constants.randomImage,
            authorID: "user_2",
            createdAt: .now,
            characterDescription: "A dog is running and barking in the yard"
        ),
        AvatarModel(
            id: "avatar_3",
            name: "Gamma",
            category: .cat,
            profileImageURL: Constants.randomImage,
            authorID: "user_3",
            createdAt: .now,
            characterDescription: "A cat sleeps in the sun in the garden"
        ),
        AvatarModel(
            id: "avatar_4",
            name: "Delta",
            category: .woman,
            profileImageURL: Constants.randomImage,
            authorID: "user_4",
            createdAt: .now,
            characterDescription: "A woman eats chocolate ice cream in a park"
        )
    ]
    
    static let mock: AvatarModel = mocks[0]
}
