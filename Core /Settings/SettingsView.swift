//
//  SettingsView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 16.04.2026.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(AuthManager.self) private var authManager
    @State private var showCreateAccountView: Bool = false
    private var isAnonymousUser: Bool {
        authManager.currentUser?.isAnonymous ?? true
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                // MARK: - Appearance
                Section("Appearance") {
                    Toggle(
                        "Dark Mode",
                        isOn: Binding(
                            get: { appState.isDarkMode },
                            set: { appState.updateColorScheme(isDarkMode: $0) }
                        )
                    )
                }
                
                // MARK: - Account
                Section("Account") {
                    if isAnonymousUser {
                        Button {
                            onCreateAccauntPressed()
                        } label: {
                            Text("Log in")
                                .foregroundStyle(.blue)
                        }
                    } else {
                        Button {
                            onSignOutPressed()
                        } label: {
                            Text("Log out")
                                .foregroundStyle(.red)
                        }
                    }
                    
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
        }
    }
    
    // MARK: - Actions
    
    private func onSignOutPressed() {
        Task {
            do {
                try authManager.signOut()              
                try await authManager.signInAnonymouslyIfNeeded()
                dismiss()
            } catch {
                print("Sign out failed: \(error)")
            }
        }
    }
    
    private func onCreateAccauntPressed() {
        showCreateAccountView = true
    }
}

#Preview("Anonymous") {
    SettingsView()
        .environment(AppState())
        .environment(AuthManager.mockAnonymous)
        .preferredColorScheme(.dark)
}

#Preview("Authenticated") {
    SettingsView()
        .environment(AppState())
        .environment(AuthManager.mockSignedIn)
        .preferredColorScheme(.dark)
}
