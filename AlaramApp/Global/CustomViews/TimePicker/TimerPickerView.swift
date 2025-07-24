//
//  TimerPickerView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct TimerPickerView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    
    @State private var isHourPickerPresented = false
    @State private var isMinutePickerPresented = false

    var body: some View {
        HStack(spacing: 10) {
            getTimeButton(title: String(format: "%02d", selectedHour), isHour: true)
            
            Text(":")
                .font(.getFont(.regular, size: 32))
                .foregroundStyle(.black)
            
            getTimeButton(title: String(format: "%02d", selectedMinute), isHour: false)
        }
        .sheet(isPresented: $isHourPickerPresented) {
            PickerSheetView(
                title: "Select Hour",
                range: 0..<24,
                selection: $selectedHour
            )
        }
        .sheet(isPresented: $isMinutePickerPresented) {
            PickerSheetView(
                title: "Select Minute",
                range: 0..<60,
                selection: $selectedMinute
            )
        }
    }
    
    func getTimeButton(title: String, isHour: Bool) -> some View {
        Button {
            if isHour {
                isHourPickerPresented = true
            } else {
                isMinutePickerPresented = true
            }
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
            .background(getGradientBackground())
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
    TimerPickerView(selectedHour: .constant(6), selectedMinute: .constant(30))
}
