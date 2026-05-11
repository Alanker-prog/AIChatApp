//
//  View+EXT.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 15.04.2026.
//

import SwiftUI

extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.accent)
            .cornerRadius(16)
    }
    
    func tappableBackground() -> some View {
        background(.black.opacity(0.001))
    }
    
    func addingGradiendBackgroundForText() -> some View {
        background(
            LinearGradient(
                stops: [
                    .init(color: .black.opacity(0), location: 0.0),
                    .init(color: .black.opacity(0.03), location: 0.4),
                    .init(color: .black.opacity(0.1), location: 0.65),
                    .init(color: .black.opacity(0.3), location: 0.9),
                    .init(color: .black.opacity(0.5), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
    )
    }
}
