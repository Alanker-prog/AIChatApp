//
//  AvatarView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 22.06.2026.
//

import SwiftUI

struct AvatarView: View {

    let imageURL: String?
    let fallbackText: String?
    var fallbackIcon: String? = nil
    var size: CGFloat = 40
    var backgroundColor: Color = .gray.opacity(0.3)

    var body: some View {
        Group {
            if let imageURL {
                ImageLoaderView(urlString: imageURL)
            } else {
                placeholderCircle
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
    
    private var placeholderCircle: some View {
        Circle()
            .fill(backgroundColor)
            .overlay {
                if let fallbackIcon {
                    Image(systemName: fallbackIcon)
                        .foregroundStyle(.white)
                        .font(.system(size: size * 0.4))
                } else {
                    Text(fallbackText ?? "?")
                        .foregroundStyle(.secondary)
                        .font(.system(size: size * 0.4))
                }
                
            }
    }
}
#Preview {
    HStack(spacing: 16) {
        AvatarView(imageURL: AvatarModel.mock.profileImageURL,
                   fallbackText: "A", size: 40)
        AvatarView(imageURL: nil, fallbackText: "B", size: 40)
        AvatarView(imageURL: nil, fallbackText: nil, size: 60)
    }
    .padding()
}
