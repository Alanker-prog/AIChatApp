//
//  AnyAppAlert.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 02.11.2026.
//
import SwiftUI

struct AnyAppAlert {
    
    let title: String
    let subtitle: String?
    
    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    init(error: Error) {
        self.title = "Error"
        self.subtitle = error.localizedDescription
    }
    
}

extension Binding where Value == Bool {
    init<T>(ifNotNil value: Binding<T?>) {
        self.init(
            get: { value.wrappedValue != nil  },
            set: { newValue in
                if !newValue {
                    value.wrappedValue = nil
                }
            })
    }
}

extension View {
    func showCustomAlert(alert: Binding<AnyAppAlert?>) -> some View {
        self.alert(
            alert.wrappedValue?.title ?? "",
            isPresented: Binding(ifNotNil: alert)) {
                Button("OK") {}
            } message: {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            }
        
    }
}
