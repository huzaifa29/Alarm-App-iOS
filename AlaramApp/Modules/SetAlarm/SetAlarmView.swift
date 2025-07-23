//
//  SetAlarmView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/07/2025.
//

import SwiftUI

struct SetAlarmView: View {
    @Binding var path: [HomeRoute]
    
    var body: some View {
        ZStack {
            PrimaryBackground()
            
            VStack(spacing: 0) {
                TopBarView(path: $path, title: "You are all set !")
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        Image(.sun)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 183, height: 183)
                        Spacer()
                    }
                    
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
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Repeat On")
                            .font(.getFont(.semiBold, size: 20))
                            .foregroundStyle(.custom2D2D40)
                            .frame(height: 32)
                        
                        Text("Monday, Tuesday, Wednesday")
                            .font(.getFont(.medium, size: 14))
                            .foregroundStyle(.custom2D2D40)
                            .frame(height: 24)
                    }
                    
                    HStack {
                        Spacer()
                        Text("Just tap 'Set Alarm' and relax — the Alarm app will handle the rest!")
                            .multilineTextAlignment(.center)
                            .font(.getFont(.medium, size: 14))
                            .foregroundStyle(.custom9A6C8D)
                        Spacer()
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
                
                Spacer()
                
                PrimaryButton(text: "Set Alarm") {
                    print("Set Alarm Tap")
                }
                .padding([.horizontal, .top], 20)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SetAlarmView(path: .constant([]))
}
