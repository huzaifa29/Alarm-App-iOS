//
//  PrimaryButton.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(text)
                .foregroundStyle(Color(.custom2D2D40))
                .font(Font.getFont(.bold, size: 18))
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(.customF4BDFF), Color(.customF4BDFF)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(.capsule)
                .overlay(
                    Capsule()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(.customF6C5FE), Color(.customF6C5FE)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                )
        }
    }
}

#Preview {
    PrimaryButton(text: "test")
}
