//
//  ImageGenerationServiceProtocol.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.10.2026.
//

protocol ImageGenerationServiceProtocol: Sendable {
    func generateImage(description: String) async throws -> String 
}
