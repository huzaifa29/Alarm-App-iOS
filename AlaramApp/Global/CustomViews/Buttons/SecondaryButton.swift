//
//  SecondaryButton.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 28/08/2025.
//

import SwiftUI

struct SecondaryButton: View {
    private let radius: CGFloat = 16
    
    var text: String
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                Spacer()
                Text(text)
                    .font(.getFont(.bold, size: 16))
                    .foregroundStyle(.custom2D2D40)
                Spacer()
            }
            .padding(.all, 12)
            .background(
                ZStack {
                    Color.hexDAA1FF
                    RoundedRectangle(cornerRadius: radius)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .customA067D0.opacity(0),
                                    .customF4BDFF
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }.clipShape(RoundedRectangle(cornerRadius: radius))
            )
        }
    }
}


#Preview {
    SecondaryButton(text: "test")
}
