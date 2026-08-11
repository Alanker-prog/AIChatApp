//
//  FirestoreUserService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 10.08.2026.
//
import SwiftUI
import FirebaseFirestore

struct FirestoreUserService: UserServiceProtocol {
    
    private var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func getUser(userID: String) async throws -> UserModel? {
       let snapshot = try await collection.document(userID).getDocument()
        
        guard snapshot.exists else {
            return nil
        }
        return try snapshot.data(as: UserModel.self)
    }
    
    func saveUser(_ user: UserModel) async throws {
        try collection.document(user.userID).setData(from: user, merge: true)
    }
    
    func deleteUser(userID: String) async throws {
        try await collection.document(userID).delete()
    }

}
