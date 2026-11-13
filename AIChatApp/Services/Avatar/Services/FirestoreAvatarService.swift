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
    
    func getAvatars(category: AvatarCategory) async throws -> [AvatarModel] {
        let snapshot = try await collection.whereField("category", isEqualTo: category.rawValue).limit(to: 20).getDocuments()
        
        return try snapshot.documents.map { document in
            try document.data(as: AvatarModel.self)
        }
    }
    
    func getAvatars(authorID: String) async throws -> [AvatarModel] {
        let snapshot = try await collection.whereField("author_id", isEqualTo: authorID).getDocuments()
        
        return try snapshot.documents.map { document in
            try document.data(as: AvatarModel.self)
        }
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        let snapshot = try await collection.order(by: "created_at", descending: true).limit(to: 20).getDocuments()
        
        return try snapshot.documents.map { document in
            try document.data(as: AvatarModel.self)
        }
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        let snapshot = try await collection.order(by: "click_count", descending: true).limit(to: 20).getDocuments()

        return try snapshot.documents.map { document in
            try document.data(as: AvatarModel.self)
        }
    }
    
    func saveAvatar(_ avatar: AvatarModel) async throws {
        let data = try Firestore.Encoder().encode(avatar)
        try await collection.document(avatar.id).setData(data)
    }
    
    func incrementClickCount(avatarID: String) async throws {
        try await collection.document(avatarID).updateData([
            "click_count": FieldValue.increment(Int64(1))
        ])
    }
}
