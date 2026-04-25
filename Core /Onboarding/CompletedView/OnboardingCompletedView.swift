//
//  OnboardingCompletedView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 15.04.2026.
//

import SwiftUI

struct OnboardingCompletedView: View {
    
    @Environment(AppState.self) private var appState
    
    @State var isLoading: Bool = false
    var selectedColor: Color 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Setup complete!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)
            
            Group {
                Text("You set up your profile.")
                +   Text("\nYou can start chatting now.")
            }
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        
        .safeAreaInset(edge: .bottom) {
            ctaButton
        }
        .padding(22)
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private var ctaButton: some View {
        Button {
            onFinishButtonPressed()
        } label: {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Finish")
                }
            }
                .callToActionButton()
        }
        .disabled(isLoading)
    }
    
    func onFinishButtonPressed() {
        isLoading = true
        
        Task {
            try await Task.sleep(for: .seconds(3))
           // try await appState.userService.updateUserProfile()
            
            appState.updateViewState(showTabBarView: true)
            isLoading = false
        }
    }
}

#Preview {
    OnboardingCompletedView( selectedColor: .yellow)
        .environment(AppState())
}
