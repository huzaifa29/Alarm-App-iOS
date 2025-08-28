//
//  SecondaryTextField.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 20/08/2025.
//

import SwiftUI

struct SecondaryTextField: View {
    
    @State private var isSecure: Bool = true
    
    var placeholder: String
    @Binding var text: String
    var fieldType = BaseTextField.FieldType.normal
    
    var body: some View {
        BaseTextField(text: $text,
                      prompt: Text(placeholder).foregroundStyle(.customCDA9C3),
                      fieldType: fieldType)
        .font(.getFont(.medium, size: 14))
        .foregroundStyle(.black)
        .tint(.black)
        .padding(.horizontal, 15)
        .padding(.top, 11)
        .padding(.bottom, 18)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.customFFF6FB)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.hexECBBE8, lineWidth: 1.5)
                )
        )
        .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 0)
    }
}

#Preview {
    SecondaryTextField(placeholder: "test", text: .constant(""))
}
