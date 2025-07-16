//
//  AlarmItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import SwiftUI

struct AlarmItemView: View {
    @State private var isToggleOn = true
    let columns = [
        GridItem(.adaptive(minimum: 90), spacing: 0)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("ic_clock")
                Text("Morning Wake up")
                    .font(.getFont(.medium, size: 14))
                    .foregroundStyle(.custom9A6C8D)
                Spacer()
                CustomToggle(isOn: $isToggleOn, onColor: .white, offColor: .white, knobColor: .white)
            }
            
            Text("06:30 AM")
                .font(.getFont(.bold, size: 16))
                .foregroundStyle(.custom433261)
            
            getOptions()
            
            HStack(spacing: 10) {
                Image("ic_music")
                Text("Your favorite tune")
                    .font(.getFont(.medium, size: 14))
                    .foregroundStyle(.custom433261)
                Spacer()
            }
            
            getButton()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 11)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.customFFF6FB))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white, .white.opacity(0)]),
                                       startPoint: .top,
                                       endPoint: .bottom), lineWidth: 1.5)
        )
    }
}

extension AlarmItemView {
    func getOptions() -> some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
            ForEach(0..<5) { index in
                Text("Every Day")
                    .font(.getFont(.medium, size: 12))
                    .foregroundStyle(.custom9A6C8D)
                    .lineLimit(1)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [.customEBE1ED.opacity(0.40), .customF4BDFF],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
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
    }
    
    func getButton() -> some View {
        ZStack {
            // Glow behind the button (like Figma's drop shadow)
            Capsule()
                .fill(Color(.customF5C1FF).opacity(0.40))
                .frame(height: 45)
                .blur(radius: 13) // half of Figma blur radius for more natural look
            
            // Main button
            Button {
                print("Tapped")
            } label: {
                HStack(spacing: 8) {
                        Image("ic_share_user") // Replace with actual asset name
                            .resizable()
                            .frame(width: 16, height: 16)
                    
                    Text("Shared by Minol Kot..")
                        .font(Font.getFont(.regular, size: 12))
                        .foregroundStyle(Color(.custom9A6C8D))
                }
                .frame(height: 30)
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
    }
}

#Preview {
    AlarmItemView()
}


