//
//  PrimaryTextField.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct PrimaryTextField: View {
    enum FieldType {
        case normal, secure, dropdown
    }
    
    var icon: String = ""
    var placeholder: String
    @Binding var text: String
    var fieldType: FieldType = .normal
    var keyboardType: UIKeyboardType = .default
    var isSecureToggleEnabled: Bool = false
    
    @State private var isSecure: Bool = true
    var placeholderColor = Color.customCDA9C3
    
    var body: some View {
        HStack(spacing: 10) {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
            
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
        .padding(.vertical, 15.5)
        .padding(.horizontal, 20)
        .font(.getFont(.semiBold, size: 18))
        .foregroundStyle(Color(.custom2D2D40))
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.customF4BDFF), Color.white.opacity(0.05)]),
                           startPoint: .top,
                           endPoint: .bottom)
        )
        .overlay(
            Capsule()
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(.customF6C5FE).opacity(0.40), Color.white.opacity(0.05)]),
                                       startPoint: .top,
                                       endPoint: .bottom), lineWidth: 1)
        )
        .clipShape(.capsule)
    }
}

extension PrimaryTextField {
    private var normalField: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .foregroundStyle(placeholderColor)
        )
        .keyboardType(keyboardType)
        .tint(.hexFFE4D2)
        .foregroundStyle(.black)
    }
    
    private var secureField: some View {
        SecureField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .foregroundStyle(placeholderColor)
        )
        .keyboardType(keyboardType)
        .tint(.hexFFE4D2)
        .foregroundStyle(.black)
    }
}

#Preview {
    PrimaryTextField(placeholder: "test", text: .constant(""))
}
