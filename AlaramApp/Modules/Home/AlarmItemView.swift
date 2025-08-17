//
//  AlarmItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import SwiftUI

struct AlarmItemView: View {
    @State private var isToggleOn = true
    @State private var selectedDays = [FrequencyData]()
    
    let columns = [
        GridItem(.adaptive(minimum: 90), spacing: 0)
    ]
    
    var alarmData: AlarmModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("ic_clock")
                Text(alarmData.name ?? "")
                    .font(.getFont(.medium, size: 14))
                    .foregroundStyle(.custom9A6C8D)
                Spacer()
                CustomToggle(isOn: $isToggleOn, onColor: .white, offColor: .white, knobColor: .white)
            }
            
            FrequencyView(title: alarmData.getFormattedTime() ?? "", titleFont: .getFont(.bold, size: 16), titleColor: .custom433261, titleHeight: 26, arrayItems: $selectedDays)
            
            HStack(spacing: 10) {
                Image("ic_music")
                Text(alarmData.music?.name ?? "")
                    .font(.getFont(.medium, size: 14))
                    .foregroundStyle(.custom433261)
                Spacer()
            }
            
            getButton()
        }
        .onAppear {
            selectedDays = alarmData.getSelectedDays()
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
    AlarmItemView(alarmData: .init(userId: "", musicId: "", name: "Test", description: "Test", type: "basic", selectedDays: [], time: nil, createdAt: nil, voiceName: nil, voiceURL: nil))
}


