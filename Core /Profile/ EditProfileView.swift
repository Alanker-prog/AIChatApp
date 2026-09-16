//
//  EditProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 31.05.2026.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(UserManager.self) private var userManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var draftDisplayName: String = ""
    @State private var didLoadDraft: Bool = false
    @State private var isSaving: Bool = false
    @State private var errorMessage: String?
    
    private var currentUser: UserModel? {
        userManager.currentUser
    }
    
    private var trimmedName: String {
        draftDisplayName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var canSave: Bool {
        currentUser != nil
        && !isSaving
        && !trimmedName.isEmpty
        && trimmedName != (currentUser?.displayName ?? "")
    }
    
    var body: some View {
        List {
            Section("Info") {
                TextField("Display name", text: $draftDisplayName)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                saveButton
            }
        }
        .alert(
            "Something went wrong",
            isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "")
        }
        .task { loadDraftIfNeeded() }
    }
    
    @ViewBuilder
    private var saveButton: some View {
        if isSaving {
            ProgressView()
        } else {
            Button("Save") {
              onSavePressed()
            }
            .disabled(!canSave)
        }
    }
    
    private func onSavePressed() {
        guard canSave else { return }
        let newName = trimmedName
        
        Task {
            isSaving = true
            defer { isSaving = false }
            
            do {
                try await userManager.updateDisplayName(newName)
                dismiss()
            } catch {
                errorMessage = "Couldn't save your name. Please try again."
            }
        }
    }
    
    private func loadDraftIfNeeded() {
        guard !didLoadDraft, let user = currentUser else { return }
        draftDisplayName = user.displayName ?? ""
        didLoadDraft = true
    }
}

#Preview("Empty") {
    NavigationStack {
        EditProfileView()
    }
    .environment(UserManager(service: MockUserService()))
    .preferredColorScheme(.dark)
}

#Preview("With user") {
    NavigationStack {
        EditProfileView()
    }
    .environment(UserManager(service: MockUserService(), currentUser: .mock))
    .preferredColorScheme(.dark)
}
