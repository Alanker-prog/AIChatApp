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
                    .fill(currentUser?.profileColorCalculated ?? .blue)
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
                Text("Screen Edit Profile")
            } label: {
                Label("Edit Profile", systemImage: "person")
            }
            
            NavigationLink {
                Text("Screen Notifications")
            } label: {
                Label("Notifications", systemImage: "bell")
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
