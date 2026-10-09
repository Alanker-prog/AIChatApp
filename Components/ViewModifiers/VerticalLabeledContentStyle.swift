//
//  VerticalLabeledContentStyle.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 09.10.2026.
//

import SwiftUI

struct VerticalLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
                .foregroundStyle(.secondary)
        }
    }
}
