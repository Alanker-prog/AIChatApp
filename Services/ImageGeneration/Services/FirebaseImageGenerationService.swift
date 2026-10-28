//
//  FirebaseImageGenerationService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.10.2026.
//
import FirebaseFunctions

private struct Request: Encodable {
    let description: String
}

private struct Response: Decodable {
    let message: String
}

struct FirebaseImageGenerationService: ImageGenerationServiceProtocol {
    
    func generateImage(description: String) async throws -> String {
        let callable = Functions.functions().httpsCallable("generateAvatarImage", requestAs: Request.self, responseAs: Response.self)
        let response = try await callable.call(Request(description: description))
        return response.message
    }
}

