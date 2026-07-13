//
//  UserAuthInfo+Firebase.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 08.07.2026.
//
import FirebaseAuth

extension UserAuthInfo {
    init(user: FirebaseAuth.User) {
        self.init(
            uid: user.uid,
            isAnonymous: user.isAnonymous,
            email: user.email,
            displayName: user.displayName,
            creationDate: user.metadata.creationDate,
            lastSignInDate: user.metadata.lastSignInDate
        )
    }
}
