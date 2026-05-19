//
//  ChatRowCellView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 14.05.2026.
//

import SwiftUI

struct ChatRowCellView: View {
    
    var imageName: String? = Constants.randomeImage
    var headline: String? = "Delta"
    var subheadline: String? = "This is the first message in the chat"
    var hasNewMessage: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .overlay {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.gray)
                        }
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 4) {
                if let headline {
                    Text(headline)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                if let subheadline {
                    Text(subheadline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            if hasNewMessage {
                Text("new")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color(.secondarySystemBackground)) 
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ZStack {
        Color(.systemBackground).ignoresSafeArea()
        
        VStack {
            ChatRowCellView()
            ChatRowCellView(hasNewMessage: true)
            ChatRowCellView(imageName: nil)
            ChatRowCellView(headline: nil)
            ChatRowCellView(subheadline: nil, hasNewMessage: true)
            ChatRowCellView(headline: nil,subheadline: nil, hasNewMessage: true)
        }
        .padding()
    }
    .preferredColorScheme(.dark)  // ← тёмная тема
}
