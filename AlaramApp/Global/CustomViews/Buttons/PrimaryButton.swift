//
//  PrimaryButton.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct PrimaryButton: View {
    var leftIcon: String?
    var text: String
    var iconSpacing: CGFloat = 12
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                // Outer glow layer
                Capsule()
                    .fill(Color.clear)
                    .background(
                        Capsule()
                            .fill(Color.customF5C1FF.opacity(0.7))
                            .blur(radius: 15.3)
                            .offset(y: 10)
                    )
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)

                // Main capsule background and borders
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .customF4BDFF,
                                .customF4BDFF.opacity(0.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .overlay(
                        Capsule()
                            .strokeBorder(
                                LinearGradient(
                                    colors: [.customF6C5FE, .white],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1
                            )
                    )
                    .clipShape(Capsule())
                    .shadow(color: .customF5C1FF.opacity(0.4), radius: 26, x: 0, y: 13)
                    .overlay(
                        Capsule()
                            .fill(Color.white.opacity(0.5))
                            .blur(radius: 8)
                            .offset(x: -6, y: 9)
                            .mask(Capsule())
                    )
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)

                HStack(spacing: iconSpacing) {
                    if let leftIcon = leftIcon {
                        Image(leftIcon) // Replace with actual asset name
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text(text)
                        .font(Font.getFont(.bold, size: 18))
                        .foregroundStyle(Color(.custom2D2D40))
                }
            }
        }
    }
}

#Preview {
    PrimaryButton(text: "test")
}
