//
//  BaseTextField.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 28/08/2025.
//


import SwiftUI

struct BaseTextField: View {
    enum FieldType {
        case normal, secure, dropdown
    }
    
    @Binding var text: String
    var prompt: Text?
    
    var icon: String?
    var iconSize: CGSize = .init(width: 24, height: 24)
    var spacing: CGFloat = 10
    
    var fieldType: FieldType = .normal
    var keyboardType: UIKeyboardType = .default
    var isSecureToggleEnabled: Bool = false
    
    @State private var isSecure: Bool = true
    @State private var localText: String = "" // Local state to preserve text
    
    var body: some View {
        HStack(spacing: spacing) {
            // Icon
            if let icon = icon {
                Image(icon)
                    .resizable()
                    .frame(width: iconSize.width, height: iconSize.height)
            }
            
            // Text Field
            textFieldContent
            
            // Secure toggle button
            if fieldType == .secure && isSecureToggleEnabled {
                secureToggleButton
            }
            
            // Dropdown indicator
            if fieldType == .dropdown {
                dropdownIndicator
            }
        }
        .onAppear {
            localText = text
        }
        .onChange(of: text) {
            localText = text
        }
    }
}

// MARK: - Methods
extension BaseTextField {
    
    @ViewBuilder
    private var textFieldContent: some View {
        if fieldType == .secure && isSecureToggleEnabled {
            Group {
                if isSecure {
                    secureField
                } else {
                    normalField
                }
            }
            .id("secure_toggle_\(isSecure)")
        } else if fieldType == .secure {
            secureField
        } else {
            normalField
        }
    }
    
    private var normalField: some View {
        TextField(
            "",
            text: Binding(
                get: { localText },
                set: { newValue in
                    localText = newValue
                    text = newValue
                }
            ),
            prompt: prompt
        )
        .keyboardType(keyboardType)
    }
    
    private var secureField: some View {
        SecureField(
            "",
            text: Binding(
                get: { localText },
                set: { newValue in
                    localText = newValue
                    text = newValue
                }
            ),
            prompt: prompt
        )
        .keyboardType(keyboardType)
    }
    
    private var secureToggleButton: some View {
        Button(action: {
            // Preserve the current text before toggling
            let currentText = localText
            withAnimation(.easeInOut(duration: 0.1)) {
                isSecure.toggle()
            }
            // Restore text after a brief delay to ensure view is recreated
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                localText = currentText
                text = currentText
            }
        }) {
            Image(isSecure ? "ic_eye" : "ic_eye_slash")
        }
    }
    
    private var dropdownIndicator: some View {
        Image(systemName: "chevron.down")
    }
}
