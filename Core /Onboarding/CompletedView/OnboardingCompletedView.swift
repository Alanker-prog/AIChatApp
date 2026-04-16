//
//  OnboardingCompletedView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 15.04.2026.
//

import SwiftUI

struct OnboardingCompletedView: View {
    
    @Environment(AppState.self) private var appState
    
    var body: some View {
        VStack {
            Text("Onboarding Comleted")
                .font(.headline)
                .frame(maxHeight: .infinity)
            
            Button {
                onFinishButtonPressed()
            } label: {
                Text("Finish")
                    .callToActionButton()
            }
            
        }
        .padding(16)
        
    }
    
    func onFinishButtonPressed() {
        appState.updateViewState(showTabBarView: true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
