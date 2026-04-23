//
//  WelcomeView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//
import SwiftUI

struct WelcomeView: View {
    
    @State var imageName: String = Constants.randomeImage
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // 🔹 Фон
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()
                
                // 🔹 Градиент
                LinearGradient(
                    colors: [
                        .clear,
                        .black.opacity(0.4),
                        .black.opacity(0.4),
                        .black.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // 🔹 Контент
                VStack {
                    Spacer()
                    titleSection
                    
                    VStack(spacing: 12) {
                        ctaSection
                        policySection
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding()
                }
            }
        }
    }
    
    // MARK: - Sections
    
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("AI Chat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Claude AI: Sonnet 4.6")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.8))
        }
    }
    
    private var ctaSection: some View {
        VStack(spacing: 8) {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            
            Text("Already have an account? Sign in.")
                .font(.headline)
                .foregroundStyle(.white)
                .onTapGesture {
                    
                }
        }
    }
    
    private var policySection: some View {
        HStack(spacing: 8) {
            Link("Terms of Service",
                 destination: URL(string: Constants.termsOfServiceUrl)!)
            
            Circle()
                .fill(.white.opacity(0.6))
                .frame(width: 4, height: 4)
            
            Link("Privacy Policy",
                 destination: URL(string: Constants.privacyPolicyUrl)!)
        }
        .font(.footnote)
        .foregroundStyle(.white.opacity(0.8))
    }
}

#Preview {
    WelcomeView()
}
