//
//  OnboardingIntroView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 22.04.2026.
//

import SwiftUI

struct OnboardingIntroView: View {
    var body: some View {
        
            VStack {
                Group {
                    Text("Make your own ")
                    + Text("avatars")
                        .foregroundStyle(Color.accentColor)
                        .fontWeight(.semibold)
                    + Text(" and chats with them!\n\nHave ")
                    + Text("real conversations")
                        .foregroundStyle(Color.accentColor)
                        .fontWeight(.semibold)
                    + Text(" with AI generated responses")
                }
                .frame(maxHeight: .infinity)
                .baselineOffset(2)
                
                NavigationLink {
                    OnboardingColorView()
                } label: {
                    Text("Continue")
                        .callToActionButton()
                }
            }
            .font(.title3)
            .padding(20)
        }
    }

#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
