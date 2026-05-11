//
//  PopularCellView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 06.05.2026.
//

import SwiftUI

struct PopularCellView: View {
    
    var imageName: String? = Constants.randomeImage
    var title: String? = "Alfa"
    var subtitle: String? = "An alien that is smiling in the park"
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.gray).opacity(0.5)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 60)
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(20)
        
    }
}

#Preview {
    ZStack {
        Color(.gray).ignoresSafeArea()
        
        VStack {
            PopularCellView()
            PopularCellView(imageName: nil)
            PopularCellView(title: nil)
            PopularCellView(subtitle: nil)
        }
            
    }
        
}
