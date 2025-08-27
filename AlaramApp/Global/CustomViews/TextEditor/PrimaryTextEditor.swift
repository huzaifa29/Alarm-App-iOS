//
//  PrimaryTextEditor.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 28/08/2025.
//

import SwiftUI

struct PrimaryTextEditor: View {
    
    @State var placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Placeholder
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(Color.customCDA9C3)
                    .font(.getFont(.medium, size: 14))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 20)
                    .zIndex(1)
            }
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .tint(.hexECBBE8)
                .background(.clear)
                .frame(height: 150)
                .font(.getFont(.medium, size: 14))
                .foregroundStyle(.black)
                .padding(.horizontal, 8)
                .padding(.vertical, 10) // ensures alignment with placeholder
        }
        .frame(height: 150)
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
    PrimaryTextEditor(placeholder: "test", text: .constant(""))
}
