//
//  TimerPickerView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct TimerPickerView: View {
    var body: some View {
        HStack(spacing: 10) {
            getTimeButton(title: "06")
            
            Text(":")
                .font(.getFont(.regular, size: 32))
                .foregroundStyle(.black)
            
            getTimeButton(title: "30")
        }
    }
}

extension TimerPickerView {
    func getTimeButton(title: String) -> some View {
        Button {
            print("Tap")
        } label: {
            HStack(spacing: 5) {
                Text(title)
                    .font(.getFont(.regular, size: 32))
                    .foregroundStyle(.black)
                
                Image(.chevronDown)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .frame(width: 95, height: 66)
            .background(
                getGradientBackground()
            )
            
        }
    }
    
    func getGradientBackground() -> some View {
        ZStack {
            Capsule()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .customF4BDFF.opacity(0.40),
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
        }
    }
}

#Preview {
    TimerPickerView()
}
