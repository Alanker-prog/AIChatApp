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
                Button {
                    onSignOutPressed()
                } label: {
                    Text("Sign out")
                }

            }
            .navigationTitle("Settings")
        }

    }
    
    func onSignOutPressed() {
            dismiss() // сначала закрываем sheet
            Task {
                try? await Task.sleep(for: .seconds(0.3)) // ждём анимацию закрытия
                appState.updateViewState(showTabBarView: false)
            }
        }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
