//
//  CategoryCellView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 05.05.2026.
//

import SwiftUI

struct CategoryCellView: View {
    
    var title: String = "Aliens"
    var imageName: String = "category_man"
    var font: Font = .title2.bold()
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading, content: {
                Text(title)
                    .font(font)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addingGradiendBackgroundForText()
            })
            .cornerRadius(cornerRadius)
            
    }
}

#Preview {
    VStack {
        CategoryCellView()
            .frame(width: 150)
        
        CategoryCellView()
            .frame(width: 300)
    }
}
