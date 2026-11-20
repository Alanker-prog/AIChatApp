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
    @Environment(UserManager.self) private var userManager
    @State private var showCreateAccountView: Bool = false
    @State private var alert: AnyAppAlert?
    private var isAnonymousUser: Bool {
        authManager.currentUser?.isAnonymous ?? true
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Toggle(
                        "Dark Mode",
                        isOn: Binding(
                            get: { appState.isDarkMode },
                            set: { appState.updateColorScheme(isDarkMode: $0) }
                        )
                    )
                }
                Section("Account") {
                    if isAnonymousUser {
                        Button {
                            onCreateAccountPressed()
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
            .showCustomAlert(alert: $alert)
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
        }
    }
    
    // MARK: - Actions
    
    // TODO: Реализовать удаление аккаунта (Delete Account) — отдельная кнопка с подтверждением.
    // Порядок критичен:
    //   1. userManager.stopListening()
    //   2. userManager.deleteUser(...) — документ удаляем, ПОКА auth жив
    //      (правила требуют request.auth != nil; после удаления аккаунта прав уже не будет)
    //   3. authManager.deleteAccount() — добавить в AuthServiceProtocol + мок +
    //      FirebaseAuthService (Auth.auth().currentUser?.delete())
    // Возможна ошибка requiresRecentLogin для старых аккаунтов.
    private func onSignOutPressed() {
        do {
            userManager.stopListening()
            try authManager.signOut()
            dismiss()
        } catch {
            alert = .init(error: error)
        }
    }
    
    // TODO: После signOut аноним не может войти обратно в той же сессии —
    // currentUser остаётся nil, а единственный путь входа (эта кнопка → CreateAccountView)
    // ждёт реализации Apple Sign In. Исчезнет, когда будет сделан Apple Sign In
    // (link credential к текущему uid). Требует платного Developer-аккаунта.
    private func onCreateAccountPressed() {
        showCreateAccountView = true
    }
}

#Preview("Anonymous") {
    SettingsView()
        .environment(AuthManager.mockAnonymous)
        .previewEnvironment()
        .preferredColorScheme(.dark)
}

#Preview("Authenticated") {
    SettingsView()
        .previewEnvironment()
        .preferredColorScheme(.dark)
}
