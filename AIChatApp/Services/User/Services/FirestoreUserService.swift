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

    func userStateStream(userID: String) -> AsyncThrowingStream<UserModel?, Error> {
        AsyncThrowingStream { continuation in
            
            let task = Task {
                do {
                    for try await snapshot in collection.document(userID).snapshots {
                        if snapshot.exists {
                            let user = try snapshot.data(as: UserModel.self)
                            continuation.yield(user)
                        } else {
                            continuation.yield(nil)
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { @Sendable _ in
                task.cancel()
            }
        }
    }
}
