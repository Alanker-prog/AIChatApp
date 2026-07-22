//
//  AppView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 13.04.2026.
//

import SwiftUI

struct AppView: View {
    
    @State var appState: AppState = AppState()
    @State var authManager = AuthManager(service: FirebaseAuthService())
    
    var body: some View {
        AppViewBuilder(
            showTabbar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboarding: {
               WelcomeView()
            }
        )
        .environment(appState)
        .environment(authManager)
        .task {
            authManager.startListening() 
            await signInIfNeeded()
        }
    }
    
    private func signInIfNeeded() async {
        do {
            try await authManager.signInAnonymouslyIfNeeded()
        } catch {
            print("Sign in failed: \(error)")
        }
    }
}
#Preview("AppView - Tabbar") {
    AppView(
        appState: AppState(showTabBar: true),
        authManager: AuthManager(service: MockAuthService())
    )
    
}
#Preview("AppView - Onboarding") {
    AppView(
        appState: AppState(showTabBar: false),
        authManager: AuthManager(service: MockAuthService())
    )
}
