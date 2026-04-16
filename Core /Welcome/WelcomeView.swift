//
//  WelcomeView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .font(.headline)
                    .frame(maxHeight: .infinity)
                
                NavigationLink {
                    OnboardingCompletedView()
                } label: {
                    Text("Get Started")
                        .callToActionButton()
                }

            }
            .padding(16)
        }
    }
}

#Preview {
    WelcomeView()
}
