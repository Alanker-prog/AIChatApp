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
}
