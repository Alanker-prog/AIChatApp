//
//  AIChatAppApp.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 10.04.2026.
//

import SwiftUI
import FirebaseCore

@main
struct AIChatAppApp: App {

    @State private var appState = AppState()
    @State private var authManager = AuthManager(service: FirebaseAuthService())  // 👈
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(appState)
                .environment(authManager)          // 👈 прокидываем менеджер
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
