//
//  ButtonViewModifiers.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 10.05.2026.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.secondary.opacity(0.5) : Color.secondary.opacity(0)
            }
            .animation(.snappy(duration: 0.4, extraBounce: 0), value: configuration.isPressed)
    }
}

struct PressableButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtonStyleOption {
    case highlight
    case pressable
    case plain
}

extension View {
    
    @ViewBuilder
    func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .highlight:
            self.highlightButton { action() }
        case .pressable:
            self.pressableButton { action() }
        case .plain:
            self.plainButton { action() }
            
        }
        
    }
    
    private func plainButton(action: @escaping () -> Void) -> some View {
         Button {
             action()
         } label: {
             self
         }
         .buttonStyle(PlainButtonStyle())
     }
    
   private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }
    
  private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    VStack {
        
        Button {
            
        } label: {
            Text("Custom Button")
                .padding()
                .frame(maxWidth: .infinity)
                .anyButton(.highlight) {
                    
                }
        }
        .cornerRadius(10)
        .padding()
    
        Button {
            
        } label: {
            Text("Button")
                .callToActionButton()
                .anyButton(.pressable, action: {
                    
                })
                .padding()
        }
        
        Button {
            
        } label: {
            Text("Button")
                .callToActionButton()
                .anyButton(.plain, action: {
                    
                })
                .padding()
        }
    }
}
