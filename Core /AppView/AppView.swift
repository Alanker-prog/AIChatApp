//
//  AppView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 13.04.2026.
//

import SwiftUI

private struct AppView: View {
    
    @AppStorage("showTabbarView") var showTabbar: Bool = false
    
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
#Preview("AppView - Tabbar") {
    AppView(showTabbar: true)
}
#Preview("AppView - Onboarding") {
    AppView(showTabbar: false)
}
