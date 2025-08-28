//
//  TertiaryTextField.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 28/08/2025.
//

import SwiftUI

struct TertiaryTextField: View {
    
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
        .padding(.vertical, 15.5)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.hexFFE4D2, lineWidth: 4)
                )
        )
    }
}

// MARK: - Preview
#Preview {
    TertiaryTextField(placeholder: "Placeholder", text: .constant(""))
}
