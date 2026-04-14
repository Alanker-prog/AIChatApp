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
                    .transition(.move(edge: .trailing))
            } else {
                onboarding
                    .transition(.move(edge: .leading))
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
