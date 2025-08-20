//
//  SecondaryTextField.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 20/08/2025.
//

import SwiftUI

struct SecondaryTextField: View {
    enum FieldType {
        case normal, secure, dropdown
    }
    
    var icon: String?
    var placeholder: String
    @Binding var text: String
    var fieldType: FieldType = .normal
    var keyboardType: UIKeyboardType = .default
    var isSecureToggleEnabled: Bool = false
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        HStack(spacing: 10) {
            if let icon = icon {
                Image(icon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            if fieldType == .secure && isSecureToggleEnabled {
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                            .keyboardType(keyboardType)
                    } else {
                        TextField(placeholder, text: $text)
                            .keyboardType(keyboardType)
                    }
                }
            } else if fieldType == .secure {
                SecureField(placeholder, text: $text)
                    .keyboardType(keyboardType)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
            }
            
            if fieldType == .secure && isSecureToggleEnabled {
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(isSecure ? "ic_eye" : "ic_eye_slash")
                        .foregroundColor(Color.purple.opacity(0.7))
                }
            }
            
            if fieldType == .dropdown {
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.purple.opacity(0.7))
            }
        }
        .font(.getFont(.medium, size: 14))
        .foregroundStyle(.customCDA9C3)
        .padding(.horizontal, 15)
        .padding(.top, 11)
        .padding(.bottom, 18)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.customFFF6FB)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(colors: [.white.opacity(0), .white, .white.opacity(0)],
                                           startPoint: .top,
                                           endPoint: .bottom),
                            lineWidth: 1.5
                        )
                )
        )
        .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 0)
    }
}
