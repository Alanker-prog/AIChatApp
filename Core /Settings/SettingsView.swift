//
//  SettingsView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 16.04.2026.
//

import SwiftUI

struct SettingsView: View {
    
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
        // logic to sign user out of app!
        appState.updateViewState(showTabBarView: false)
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
