//
//  AppViewBuilder.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.04.2026.
//

import SwiftUI

struct AppViewBuilder<TabbarView: View, OnboardingView: View>: View {
    
    var showTabbar: Bool = false
    @ViewBuilder var tabbarView: TabbarView
    @ViewBuilder var onboarding: OnboardingView
    
    var body: some View {
        ZStack {
            if showTabbar {
                tabbarView
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),  // TabBar влетает справа
                            removal: .move(edge: .trailing)     // TabBar улетает вправо
                        )
                    )
            } else {
                onboarding
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .leading),   // Onboarding влетает слева
                            removal: .move(edge: .leading)      // Onboarding улетает влево
                        )
                    )
            }
        }
        .animation(.smooth, value: showTabbar)
    }
}

private struct PreviewView: View {
    
    @State var showTabbar: Bool = false
    
    var body: some View {
        AppViewBuilder(
            showTabbar: showTabbar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tabbar")
                }
            },
            onboarding: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("onboarding")
                }
            }
        )
        .onTapGesture {
            showTabbar.toggle()
        }
           
    }
}
#Preview {
    PreviewView()
}
