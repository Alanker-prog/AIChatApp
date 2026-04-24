//
//  AIChatAppApp.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 10.04.2026.
//

import SwiftUI

@main
struct AIChatAppApp: App {
    
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(appState)
        }
    }
}
