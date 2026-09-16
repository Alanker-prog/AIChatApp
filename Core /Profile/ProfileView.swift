//
//  ProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(UserManager.self) private var userManager
    @State var showSettingsView: Bool = false
    @State private var isPremium: Bool = false
    
    private var currentUser: UserModel? {
        userManager.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                profileImageSection
                
                List {
                    accountSection
                    supportSection
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettingsView = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
    }
    
    // MARK: - Sections
    
    private var profileImageSection: some View {
        VStack(spacing: 8) {
            ZStack {
                AvatarView(
                    imageURL: currentUser?.profileImageURL,
                    fallbackText: nil,
                    fallbackIcon: "person.fill",
                    size: 80,
                    backgroundColor: currentUser?.profileColor ?? .blue
                )
            }
            
            Text(currentUser?.displayName ?? "Guest User")
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }
    
    private var accountSection: some View {
        Section("Account") {
            NavigationLink {
                EditProfileView()
            } label: {
                Label("Edit Profile", systemImage: "person")
            }
            
            NavigationLink {
                Text("Screen Notifications")
            } label: {
                Label("Notifications", systemImage: "bell")
            }
            
            NavigationLink {
                Text("Premium View")
            } label: {
                HStack {
                    if isPremium {
                        Label("Premium", systemImage: "star.fill")
                            .foregroundStyle(.yellow)
                    } else {
                        Label("Free", systemImage: "star.fill")
                            .foregroundStyle(.primary)
                            
                    }
                    
                }
            }
            
        }
    }
    
    private var supportSection: some View {
        Section("Support") {
            Label("Help", systemImage: "questionmark.circle")
            Label("About", systemImage: "info.circle")
        }
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
        .environment(AppState())
        .environment(UserManager(service: MockUserService(), currentUser: .mock))
}
