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
    let character: Character
    let profileImageURL: String?
    let authorID: String
    let createdAt: Date
    
    // MARK: - Derived
    
    var description: String {
        "\(character.option.rawValue) is \(character.action.rawValue) in the \(character.location.rawValue)"
    }
}

// MARK: - Character

struct Character: Hashable {
    let option: CharacterOption
    let action: CharacterAction
    let location: CharacterLocation
}

// MARK: - Enums

enum CharacterOption: String, CaseIterable {
    case man
    case woman
    case alien
    case dog
    case cat
}

enum CharacterAction: String, CaseIterable {
    case smiling
    case sitting
    case eating
    case drinking
    case walking
    case shopping
    case studying
    case dancing
    case crying
    case sleeping
}

enum CharacterLocation: String, CaseIterable {
    case park
    case mall
    case museum
    case city
    case desert
    case forest
    case space
}

// MARK: - Mocks

extension AvatarModel {
    
    static let mocks: [AvatarModel] = [
        AvatarModel(
            id: "1",
            name: "Alfa",
            character: Character(option: .alien, action: .dancing, location: .space),
            profileImageURL: Constants.randomeImage,
            authorID: "user_1",
            createdAt: .now
        ),
        AvatarModel(
            id: "2",
            name: "Beta",
            character: Character(option: .dog, action: .sitting, location: .park),
            profileImageURL: Constants.randomeImage,
            authorID: "user_2",
            createdAt: .now
        ),
        AvatarModel(
            id: "3",
            name: "Gamma",
            character: Character(option: .cat, action: .sleeping, location: .museum),
            profileImageURL: Constants.randomeImage,
            authorID: "user_3",
            createdAt: .now
        ),
        AvatarModel(
            id: "4",
            name: "Delta",
            character: Character(option: .woman, action: .eating, location: .mall),
            profileImageURL: Constants.randomeImage,
            authorID: "user_4",
            createdAt: .now
        )
    ]
    
    static let mock: AvatarModel = mocks[0]
}
