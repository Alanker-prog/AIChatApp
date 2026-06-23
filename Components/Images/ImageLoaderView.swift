//
//  ImageLoaderView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 18.04.2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {

    var urlString: String = Constants.randomeImage
    var resizingMode: ContentMode = .fill
    var useDrawingGroup: Bool = false   // 👈 опционально, по умолчанию выключен

    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }
            .clipped()
            .modifier(OptionalDrawingGroup(isEnabled: useDrawingGroup))
            // drawingGroup() растрирует вью в bitmap через Metal.
           // Помогает от рывков картинки при анимации выезжающих панелей,
          // но замедляет загрузку и грузит GPU — включать ТОЧЕЧНО, не везде.
    }
}

// Применяет drawingGroup() только если включено
struct OptionalDrawingGroup: ViewModifier {
    let isEnabled: Bool

    func body(content: Content) -> some View {
        if isEnabled {
            content.drawingGroup()
        } else {
            content
        }
    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 300, height: 400)
}
