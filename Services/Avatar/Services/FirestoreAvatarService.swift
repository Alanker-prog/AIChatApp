//
//  FirestoreAvatarService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 15.10.2026.
//
import Foundation
import FirebaseFirestore

struct FirestoreAvatarService: AvatarServiceProtocol {
    
    private var collection: CollectionReference {
        Firestore.firestore().collection("avatars")
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        let snapshot = try await collection.order(by: "created_at", descending: true).limit(to: 20).getDocuments()
        
        return try snapshot.documents.map { document in
            try document.data(as: AvatarModel.self)
        }
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        let snapshot = try await collection.limit(to: 20).getDocuments()

        return try snapshot.documents.map { document in
            try document.data(as: AvatarModel.self)
        }
    }
}
