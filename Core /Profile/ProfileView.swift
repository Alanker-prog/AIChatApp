//
//  ProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct ProfileView: View {
    
    @State var showSettingsView: Bool = false
    @State private var currentUser: UserModel? = .mock
    @State private var isPremium: Bool = false
    
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
                Circle()
                    .fill(currentUser?.profileColor ?? .blue)
                    .frame(width: 80, height: 80)
                
                if currentUser?.profileImageURL == nil {
                    Text("АП")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            }
            
            if let currentUser {
                Text(currentUser.userID)
                    .font(.headline)
            }
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
}
