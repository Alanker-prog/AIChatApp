//
//  CarouselView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 30.04.2026.
//

import SwiftUI

struct CarouselView<T: Identifiable, Content: View>: View {
    
    var items: [T]
    @ViewBuilder var content: (T) -> Content
    @State private var selection: T.ID?
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .scrollTransition(.interactive.threshold(.visible(0.95)), transition: { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                            })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item.id)
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            .onChange(of: items.count) { _, _ in
                updateSelectionIfNeeded()
            }
            .onAppear {
                updateSelectionIfNeeded()
            }
            
            HStack(spacing: 8) {
                ForEach(items) { item in
                    Circle()
                        .fill(item.id == selection ? Color.blue : Color.gray.opacity(0.7))
                        .frame(width: 10, height: 10)
                }
            }
            .animation(.linear, value: selection)

        }
    }
    
    private func updateSelectionIfNeeded() {
        guard selection == nil, let first = items.first else { return }
        selection = first.id
    }
}

#Preview {
    CarouselView(items: AvatarModel.mocks) { item in
        HeroCellView(
            title: item.name,
            subtitle: item.description,
            imageName: item.profileImageURL 
        )
    }
        .padding()
}
