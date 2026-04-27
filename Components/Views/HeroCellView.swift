//
//  HeroCellView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 25.04.2026.
//

import SwiftUI

struct HeroCellView: View {
    
    var title: String? = "Some Ttitle"
    var subtitle: String? = "We have a subtitle here."
    var imageName: String? = Constants.randomeImage
    
    var body: some View {
        ZStack {
            if let imageName {
                ImageLoaderView(urlString: imageName)
            } else {
                Rectangle()
            }
        }
        .overlay(
            alignment: .bottomLeading,
            content: {
                VStack(alignment: .leading ,spacing: 2) {
                    if let title {
                        Text(title)
                            .font(.headline)
                    }
                    if let subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [
                         Color.black.opacity(0),
                         Color.black.opacity(0.3),
                         Color.black.opacity(0.3)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
            )
        })
        .cornerRadius(16)
    }
}

#Preview {
    ScrollView {
        VStack {
            HeroCellView()
                .frame(width: 370, height: 250)
            
            HeroCellView(title: nil)
                .frame(width: 370, height: 250)
            
            HeroCellView(subtitle: nil)
                .frame(width: 370, height: 250)
            
            HeroCellView(imageName: nil)
                .frame(width: 370, height: 250)
            
            HeroCellView()
                .frame(width: 200, height: 250)
        }
        .frame(maxWidth: .infinity)
    }
}
