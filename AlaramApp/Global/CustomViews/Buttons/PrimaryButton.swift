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
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            // Glow behind the button (like Figma's drop shadow)
            Capsule()
                .fill(Color(.customF5C1FF).opacity(0.40))
                .frame(height: 80)
                .blur(radius: 13) // half of Figma blur radius for more natural look
            
            // Main button
            Button {
                action?()
            } label: {
                HStack(spacing: 12) {
                    if let leftIcon = leftIcon {
                        Image(leftIcon) // Replace with actual asset name
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text(text)
                        .font(Font.getFont(.bold, size: 18))
                        .foregroundStyle(Color(.custom2D2D40))
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(.customF4BDFF),
                            Color(.customF4BDFF).opacity(0.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color(.customF6C5FE),
                                    Color.white
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                )
                .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    PrimaryButton(text: "test")
}
