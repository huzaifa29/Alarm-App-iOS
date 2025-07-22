//
//  ContentView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selectedIndex: Int
    let titles: [String]
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(titles.indices, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        selectedIndex = index
                    }
                }) {
                    HStack {
                        Spacer()
                        Text(titles[index])
                            .font(Font.getFont(.bold, size: 18))
                            .foregroundStyle(Color(.custom2D2D40))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .background(
                        Group {
                            if index == selectedIndex {
                                getSelectedBackground()
                            } else {
                                Color.clear
                            }
                        }
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 5)
        .background(
            Capsule()
                .fill(.custom9287FF.opacity(0.10))
        )
    }
}

extension CustomSegmentedControl {
    private func getSelectedBackground() -> some View {
        ZStack {
            Capsule()
                .fill(Color.clear)
                .background(
                    Capsule()
                        .fill(Color.customF5C1FF.opacity(0.7))
                        .blur(radius: 15.3)
                        .offset(y: 10)
                )
                .frame(height: 46)
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
                .frame(height: 46)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CustomSegmentedControl(selectedIndex: .constant(0), titles: ["1", "2", "3"])
}
