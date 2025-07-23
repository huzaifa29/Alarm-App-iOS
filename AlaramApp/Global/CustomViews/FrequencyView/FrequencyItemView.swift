//
//  FrequencyItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct FrequencyItemView: View {
    var text: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(text)
            .font(.getFont(.medium, size: 12))
            .foregroundStyle(isSelected ?  .custom2D2D40 : .custom9A6C8D)
            .lineLimit(1)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Group {
                    if isSelected {
                        getUnselectedBackground()
                    } else {
                        getUnselectedBackground()
                    }
                }
            )
            
    }
}

extension FrequencyItemView {
    func getSelectedBackground() -> some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [.custom9287FF.opacity(0.10), .custom9287FF],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(
                Capsule()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                .customA88CF2.opacity(0),
                                .customA88CF2
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 0.5
                    )
            )
    }
    
    func getUnselectedBackground() -> some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [.customEBE1ED.opacity(0.40), .customF4BDFF.opacity(0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(
                Capsule()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color(.customF1DEF4),
                                Color.white
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1
                    )
            )
    }
}

#Preview {
    FrequencyItemView(text: "Every Day")
}
