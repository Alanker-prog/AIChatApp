//
//  MockImageGenerationService.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.10.2026.
//
import Foundation

struct MockImageGenerationService: ImageGenerationServiceProtocol {
    
    func generateImage(description: String) async throws -> String {
        try await Task.sleep(for: .seconds(0.5))
        return Constants.randomImage
    }
}
