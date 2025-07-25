//
//  TimeView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct TimeView: View {
    @State var selectedHour: Int = 6
    @State var selectedMinute: Int = 30
    @State var alarmNote = ""
    
    var onSaveTap: ((_ hour: Int, _ minute: Int, _ note: String) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Text("Morning Wake Up")
                    .font(.getFont(.semiBold, size: 18))
                    .foregroundStyle(.custom2D2D40)
                    .frame(height: 28)
                    .padding(.vertical, 7.5)
                
                Spacer()
            }
            .background(
                getGradientBackground()
            )
            
            VStack(spacing: 10) {
                
                TimerPickerView(selectedHour: $selectedHour, selectedMinute: $selectedMinute)
                
                Text("Set alarm time when you want alarm to go off")
                    .font(.getFont(.medium, size: 14))
                    .foregroundStyle(.custom9A6C8D)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        .white.opacity(0),
                                        .white,
                                        .white.opacity(0)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1.5
                            )
                    )
                    .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 0)
                
                ZStack(alignment: .topLeading) {
                    // Placeholder
                    if alarmNote.isEmpty {
                        Text("Enter note about this alarm(optional)")
                            .foregroundStyle(.customCDA9C3)
                            .font(.getFont(.medium, size: 14))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 20)
                            .zIndex(1)
                    }
                        
                    TextEditor(text: $alarmNote)
                        .frame(height: 150)
                        .font(.getFont(.medium, size: 14))
                        .foregroundStyle(.customCDA9C3)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10) // ensures alignment with placeholder
                        .background(Color.clear)
                }
            }
            .frame(height: 150)
            
            HStack {
                Text("You can add any additional notes or reminders for this alarm.")
                    .font(.getFont(.medium, size: 14))
                    .foregroundStyle(.custom9A6C8D)
                    .padding(.top, 5)
                Spacer()
            }
            
            Spacer()
            
            PrimaryButton(text: "Save Changes") {
                onSaveTap?(selectedHour, selectedMinute, alarmNote)
            }
            .padding(.top, 20)
            
        }
        .padding([.horizontal, .top], 20)
    }
}

extension TimeView {
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
}


#Preview {
    TimeView()
}
