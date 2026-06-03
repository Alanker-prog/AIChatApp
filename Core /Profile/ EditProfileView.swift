//
//  EditProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 31.05.2026.
//

import SwiftUI
import PhotosUI

// MARK: - Profile Photo State

enum ProfilePhotoState: Equatable {
    case loading
    case generating
    case selected(UIImage)
    case generated(UIImage)
    case placeholder
}

// MARK: - Avatar Service (абстракция-прослойка)

/// Прослойка между UI и источником данных.
/// Сейчас — мок. Позже сюда подставится Firebase-реализация без изменений во View.
protocol AvatarServiceProtocol: Sendable {
    func generateAvatar() async throws -> UIImage
    func uploadAvatar(_ image: UIImage) async throws
}

struct MockAvatarService: AvatarServiceProtocol {
    func generateAvatar() async throws -> UIImage {
        try await Task.sleep(for: .seconds(3))
        return UIImage(systemName: "star.fill") ?? UIImage()
    }

    func uploadAvatar(_ image: UIImage) async throws {
        try await Task.sleep(for: .seconds(1))
        // no-op в моке
    }
}

// MARK: - Edit Profile View

struct EditProfileView: View {

    // Инжектим сервис — для превью/тестов мок, в проде подменишь на Firebase-реализацию
    let avatarService: AvatarServiceProtocol

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var currentUser: UserModel? = .mock
    @State private var photoState: ProfilePhotoState = .placeholder
    @State private var errorMessage: String?

    private let photoSize: CGFloat = 100

    init(avatarService: AvatarServiceProtocol = MockAvatarService()) {
        self.avatarService = avatarService
    }

    var body: some View {
        List {
            photoSection
            infoSection
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
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
    }

    // MARK: - Sections

    private var photoSection: some View {
        Section {
            VStack(spacing: 12) {
                photoCircle
                    .frame(width: photoSize, height: photoSize)
                    .overlay(alignment: .bottomTrailing) {
                        aiGenerateButton
                    }

                PhotosPicker(selection: $selectedPhoto) {
                    Text("Set New Photo")
                        .font(.callout)
                        .foregroundStyle(.blue)
                }
            }
            .frame(maxWidth: .infinity)
            .onChange(of: selectedPhoto) { _, newValue in
                handlePhotoSelection(newValue)
            }
        }
        .listRowBackground(Color.clear)
    }

    private var infoSection: some View {
        Section("Info") {
            Text("Username: \(currentUser?.userID ?? "")")
        }
    }

    // MARK: - Components

    @ViewBuilder
    private var photoCircle: some View {
        switch photoState {
        case .loading:
            Circle()
                .fill(currentUser?.profileColor ?? .blue)
                .overlay {
                    ProgressView().tint(.white)
                }

        case .generating:
            Circle()
                .fill(currentUser?.profileColor ?? .blue)
                .overlay {
                    ProgressView().tint(.purple)
                }

        case .selected(let uiImage), .generated(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())

        case .placeholder:
            Circle()
                .fill(currentUser?.profileColor ?? .blue)
                .overlay {
                    Text(currentUser?.initials ?? "?")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
        }
    }

    private var aiGenerateButton: some View {
        Button {
            onGenerateImagePressed()
        } label: {
            ZStack {
                Circle()
                    .fill(.primary)
                    .frame(width: 28, height: 28)

                Image(systemName: "sparkles")
                    .font(.caption)
                    .foregroundStyle(.white)
            }
            .offset(x: 10, y: -10)
        }
        .disabled(photoState == .generating)
    }

    // MARK: - Actions

    private func handlePhotoSelection(_ item: PhotosPickerItem?) {
        Task {
            photoState = .loading
            if let data = try? await item?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                photoState = .selected(uiImage)
            } else {
                photoState = .placeholder
            }
        }
    }

    private func onGenerateImagePressed() {
        guard photoState != .generating else { return }
        let previousState = photoState
        photoState = .generating

        Task {
            do {
                let image = try await avatarService.generateAvatar()
                photoState = .generated(image)
            } catch {
                photoState = previousState
                errorMessage = "Couldn't generate an image. Please try again."
                print("Image generation failed: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
    .preferredColorScheme(.dark)
}
