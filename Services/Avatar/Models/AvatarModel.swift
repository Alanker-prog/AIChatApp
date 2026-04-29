//
//  AvatarModel.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.04.2026.
//

import Foundation

struct AvatarModel {
    
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let autorId: String?
    let dateCreated: Date?
    
    init(
        avatarId: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        autorId: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.autorId = autorId
        self.dateCreated = dateCreated
    }
    
    var characterDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }
    
    static var mock: AvatarModel {
        mocks[0]
    }
    
    static var mocks: [AvatarModel] {
        [
            AvatarModel(avatarId: UUID().uuidString, name: "Alfa", characterOption: .alien, characterAction: .dancing, characterLocation: .spase, profileImageName: Constants.randomeImage, autorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarId: UUID().uuidString, name: "Beta", characterOption: .dog, characterAction: .sitting, characterLocation: .park, profileImageName: Constants.randomeImage, autorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarId: UUID().uuidString, name: "Gamma", characterOption: .cat, characterAction: .sleeping, characterLocation: .museum, profileImageName: Constants.randomeImage, autorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarId: UUID().uuidString, name: "Delta", characterOption: .women, characterAction: .eating, characterLocation: .moll, profileImageName: Constants.randomeImage, autorId: UUID().uuidString, dateCreated: .now)
        ]
    }
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation
    
    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }
    
    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .`default`
        self.characterAction = avatar.characterAction ?? .`default`
        self.characterLocation = avatar.characterLocation ?? .`default`
    }
    
    var characterDescription: String {
        "A \(characterOption.rawValue) this is \(characterAction.rawValue) in the \(characterLocation.rawValue)"
    }
}

enum CharacterOption: String {
    case man, women, alien, dog, cat
    
    static var `default`: Self {
        .man
    }
}

enum CharacterAction: String {
    case smiling, sitting, eating, drinking, wolking, shopping, studying, dancing, crying, sleeping
    
    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation: String {
    case park, moll, museum, city, desert, forest, spase
    
    static var `default`: Self {
        .park
    }
}
