//
//  PreviewAlarmView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct PreviewAlarmView: View {
    @Binding var path: [HomeRoute]
    var isPreviewScreen = true
    
    var body: some View {
        ZStack {
            PrimaryBackground()
            
            VStack(spacing: 0) {
                if isPreviewScreen {
                    TopBarView(path: $path, title: "Preview Alarm")
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Morning Wake Up")
                        .font(.getFont(.bold, size: 20))
                        .foregroundStyle(.custom2D2D40)
                    
                    HStack {
                        Spacer()
                        TimerPickerView()
                        Spacer()
                    }
                    
                    HStack(spacing: 12) {
                        Image(.music)
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Your Music")
                                .font(.getFont(.bold, size: 16))
                                .foregroundStyle(.custom433261)
                            
                            Text("Name of music/song here")
                                .font(.getFont(.medium, size: 14))
                                .foregroundStyle(.custom433261)
                            
                        }
                        .frame(height: 55)
                        .padding(.vertical, 11)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.customEBE1ED.opacity(0.40), .customF4BDFF.opacity(0)]),startPoint: .top, endPoint: .bottom)
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
                    )
                    .frame(height: 77)
                    
                    FrequencyView(title: "Repeat On")
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
                
                if isPreviewScreen {
                    Spacer()
                    
                    PrimaryButton(text: "Save Details") {
                        print("Save Details Tap")
                    }
                    .padding(.all, 20)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    PreviewAlarmView(path: .constant([]))
}
