//
//  CreateAvatarView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 22.10.2026.
//

import SwiftUI

struct CreateAvatarView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var category: AvatarCategory = .alien
    @State private var characterDescription: String = ""
    @State private var isSaving: Bool = false
    @State private var alert: AnyAppAlert?
    
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !characterDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                }
                Section {
                    Picker("Category", selection: $category) {
                        ForEach(AvatarCategory.allCases, id: \.self) { item in
                            Text(item.rawValue.capitalized)
                                .tag(item)
                        }
                    }
                }
                Section {
                    TextField("Description", text: $characterDescription, axis: .vertical)
                }
                
            }
            .showCustomAlert(alert: $alert)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(isSaving)
                }
                ToolbarItem(placement: .confirmationAction) {
                    saveButton
                }
            }
            .navigationTitle("Create Avatar")
        }
    }
    
    @ViewBuilder
    private var saveButton: some View {
        if isSaving {
            ProgressView()
        } else {
            Button("Save") {
                Task { await saveAvatar() }
            }
            .disabled(!canSave)
        }
    }
    
    private func saveAvatar() async {
        guard let uid = authManager.currentUser?.uid else { return }
        isSaving = true
        let description = characterDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let imageURL = try await avatarManager.generateImage(description: description)
            let avatar = AvatarModel(
                id: UUID().uuidString,
                name: name.trimmingCharacters(in: .whitespaces),
                category: category,
                profileImageURL: imageURL,
                authorID: uid,
                createdAt: .now,
                characterDescription: description
            )
            try await avatarManager.saveAvatar(avatar)
            dismiss()
        } catch {
            alert = .init(error: error)
        }
        isSaving = false
    }
}

#Preview {
    CreateAvatarView()
        .environment(AuthManager.mockSignedIn)
        .environment(AvatarManager.mock)
}
