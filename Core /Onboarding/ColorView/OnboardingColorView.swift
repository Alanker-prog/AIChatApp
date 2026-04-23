//
//  OnboardingColorView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 22.04.2026.
//

import SwiftUI

struct OnboardingColorView: View {
    
    @State private var selectedColor: Color?
    let profileColors: [Color] = [.blue, .yellow, .green, .purple, .pink, .orange, .mint, .cyan, .indigo]
    
    var body: some View {
        ScrollView {
            colorGrid
        }
        .padding()
        
        .safeAreaInset(edge: .bottom) {
            if selectedColor != nil {
                ctaButton
                    .padding()
                    .background(.ultraThinMaterial)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: selectedColor)
        
    }
    
    private var ctaButton: some View {
        NavigationLink {
            OnboardingCompletedView()
        } label: {
            Text("Continue")
                .callToActionButton()
        }
    }
    
    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
            alignment: .center,
            spacing: 16,
            pinnedViews: .sectionHeaders,
            content: {
                Section(content: {
                    ForEach(profileColors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .overlay {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(.black)
                                    color
                                        .clipShape(.circle)
                                        .padding(selectedColor == color ? 6 : 0)
                                }
                            }
                            .onTapGesture {
                                selectedColor = color
                            }
                        
                    }
                }, header: {
                    Text("Select a profile color")
                        .font(.headline)
                })
            }
        )
    }
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
}
