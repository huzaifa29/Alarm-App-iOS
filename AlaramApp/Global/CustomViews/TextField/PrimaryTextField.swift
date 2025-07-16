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
    
    var icon: String
    var placeholder: String
    @Binding var text: String
    var fieldType: FieldType = .normal
    var isSecureToggleEnabled: Bool = false
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        HStack(spacing: 10) {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
            
            if fieldType == .secure && isSecureToggleEnabled {
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
            } else if fieldType == .secure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
            if fieldType == .secure && isSecureToggleEnabled {
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye" : "eye.slash")
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
