//
//  CreateAccountView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 28.05.2026.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var title: String = "Continue with:"
    var subtitle: String?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    
                    if let subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                SignInWithAppleButtonView(
                    type: .signIn,
                    style: colorScheme == .dark ? .white : .black, cornerRadius: 30
                )
                .frame(height: 50)
                .id(colorScheme)
                
                Spacer()
            }
            .padding(16)
            .padding(.top, 40)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateAccountView()
        .preferredColorScheme(.dark)
        
}
