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
                    Button {
                        onSignOutPressed()
                    } label: {
                        Text("Sign out")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Settings")
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
}

#Preview {
    SettingsView()
        .environment(AppState())
}
