//
//  ProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI
struct ProfileView: View {
    
    @State var showSettingsView: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Profile")
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
}

#Preview {
    ProfileView()
}
