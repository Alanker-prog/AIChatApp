//
//  AppView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 13.04.2026.
//

import SwiftUI

struct AppView: View {
    
    @State var appState: AppState = AppState()
    
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
    }
}
#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}
#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
