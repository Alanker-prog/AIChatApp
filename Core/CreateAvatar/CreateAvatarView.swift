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
    
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !characterDescription.trimmingCharacters(in: .whitespaces).isEmpty }
    
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
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task { await saveAvatar() }
                    }
                    .disabled(!canSave || isSaving)
                }
            }
            .navigationTitle("Create Avatar")
        }
    }
    
    private func saveAvatar() async {
        guard let uid = authManager.currentUser?.uid else { return }
        isSaving = true
        let avatar = AvatarModel(
            id: UUID().uuidString,
            name: name.trimmingCharacters(in: .whitespaces),
            category: category,
            profileImageURL: nil,
            authorID: uid,
            createdAt: .now,
            characterDescription: characterDescription.trimmingCharacters(in: .whitespaces)
        )
        do {
            let imageResult = try await avatarManager.generateImage(description: avatar.characterDescription)
            print("Image result: \(imageResult)")
            try await avatarManager.saveAvatar(avatar)
            dismiss()
        } catch {
            print("Failed to save avatar: \(error)")
        }
        isSaving = false
    }
}

#Preview {
    CreateAvatarView()
        .environment(AuthManager.mockSignedIn)
        .environment(AvatarManager.mock)
}
