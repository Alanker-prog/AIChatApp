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
    let clickCount: Int
}

enum AvatarCategory: String, Hashable, CaseIterable, Codable {
    case man
    case woman
    case alien
    case dog
    case cat
    var imageName: String {
        "category_\(rawValue)"
    }
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
        case clickCount = "click_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(AvatarCategory.self, forKey: .category)
        profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
        authorID = try container.decode(String.self, forKey: .authorID)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        characterDescription = try container.decode(String.self, forKey: .characterDescription)
        clickCount = try container.decodeIfPresent(Int.self, forKey: .clickCount) ?? 0
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
            characterDescription: "A green alien dancing among the stars",
            clickCount: 10
        ),
        AvatarModel(
            id: "avatar_2",
            name: "Beta",
            category: .dog,
            profileImageURL: Constants.randomImage,
            authorID: "user_2",
            createdAt: .now,
            characterDescription: "A dog is running and barking in the yard",
            clickCount: 30
        ),
        AvatarModel(
            id: "avatar_3",
            name: "Gamma",
            category: .cat,
            profileImageURL: Constants.randomImage,
            authorID: "user_3",
            createdAt: .now,
            characterDescription: "A cat sleeps in the sun in the garden",
            clickCount: 100
        ),
        AvatarModel(
            id: "avatar_4",
            name: "Delta",
            category: .woman,
            profileImageURL: Constants.randomImage,
            authorID: "user_4",
            createdAt: .now,
            characterDescription: "A woman eats chocolate ice cream in a park",
            clickCount: 50
        ),
        AvatarModel(
            id: "avatar_5",
            name: "Qeita",
            category: .man,
            profileImageURL: nil,
            authorID: "user_5",
            createdAt: .now,
            characterDescription: "A man climbs a mountain",
            clickCount: 70
        )
    ]
    
    static let mock: AvatarModel = mocks[0]
}
