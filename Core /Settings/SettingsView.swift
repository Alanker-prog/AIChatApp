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
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false
    
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
        dismiss()
        Task {
            try? await Task.sleep(for: .seconds(0.3))
            appState.updateViewState(showTabBarView: false)
        }
    }
    
    private func onCreateAccauntPressed() {
        showCreateAccountView = true
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
        .preferredColorScheme(.dark)
}
