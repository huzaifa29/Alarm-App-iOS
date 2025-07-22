//
//  HomeView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: [HomeRoute]
    
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                getTopView()
                
                ScrollView {
                    VStack(spacing: 20) {
                        getDatePickerSection()
                        getAlarmDataSection()
                        getSubcriptionSection()
                        getListAlarmSection()
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationDestination(for: HomeRoute.self, destination: { route in
                switch route {
                case .selectAlarmType:
                    SelectAlarmTypeView(path: $path)
                    
                case .musicLibrary:
                    MusicLibraryView(path: $path)
                    
                case .createAlarm:
                    CreateAlarmView(path: $path)
                }
            })

        }
    }
}

extension HomeView {
    func getTopView() -> some View {
        HStack(spacing: 15) {
            Image(.icAvatar)
            
            Text("Good evening, Jhon")
                .font(.getFont(.bold, size: 18))
                .foregroundStyle(.custom2D2D40)
            
            Spacer()
            
            HStack(spacing: 24) {
                Image(.icProfile)
                Image(.icNotification)
            }
        }
        .padding([.horizontal, .top], 20)
        .padding(.bottom, 30)
    }
    
    func getDatePickerSection() -> some View {
        VStack(spacing: 20) {
            HorizontalDatePicker(selectedDate: $selectedDate, dateRange: Date.nextNDays(14))
            PrimaryButton(leftIcon: "ic_add", text: "Create New Alarm", iconSpacing: 0) {
                self.path.append(.selectAlarmType)
            }
            .padding(.horizontal, 20)
        }
    }
    
    func getAlarmDataSection() -> some View {
        VStack(spacing: 10) {
            HStack {
                Text("Alarm Data")
                    .font(.getFont(.bold, size: 20))
                    .foregroundStyle(.custom2D2D40)
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 33)
                    .fill(Color(.customCAC3F5).opacity(0.20))
                    .frame(height: 240)
                    .blur(radius: 24)
                
                // Background Rounded Rectangle with border
                RoundedRectangle(cornerRadius: 33)
                    .stroke(Color.white, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 33)
                            .fill(Color.white)
                    )
                    .frame(height: 223)
                
                // Text Container
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 4) {
                                Capsule()
                                    .fill(Color(.custom89D1C6))
                                    .frame(width: 9, height: 16)
                                
                                Text("Snooze Hit Rate")
                                    .font(.getFont(.bold, size: 13))
                                    .foregroundStyle(.custom2D2D40)
                                
                            }
                            Text("80%")
                                .font(.getFont(.medium, size: 14))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 4) {
                                Capsule()
                                    .fill(Color(.customFFC5C4))
                                    .frame(width: 9, height: 16)
                                
                                Text("Wake On time")
                                    .font(.getFont(.bold, size: 13))
                                    .foregroundStyle(.custom2D2D40)
                                
                            }
                            Text("80%")
                                .font(.getFont(.medium, size: 14))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.leading, 33)
                
                // Progress Container
                HStack {
                    Spacer()
                    MultiLayerProgressView()
                        .frame(width: 120, height: 157)
                }
                .padding(.trailing, 33)
                
            }
            
        }
        .padding(.horizontal, 20)
    }
    
    func getSubcriptionSection() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Subscribe for upgrade your discipline partner ")
                    .font(.getFont(.bold, size: 14))
                    .foregroundStyle(.custom2D2D40)
                    .frame(width: 191)
                
                Button {
                    print("View Details Tap")
                } label: {
                    Text("View Details")
                        .frame(width: 97, height: 36)
                        .font(.getFont(.bold, size: 12))
                        .foregroundStyle(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(.customABA3F4),
                                    Color(.customF5B3FF)
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
            
            Spacer()
            
            VStack {
                Spacer()
                Image(.subscriptionIcon)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(.customF4BDFF),
                            Color(.customF4BDFF).opacity(0.50)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
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
        )
        .padding(.horizontal, 20)
        .shadow(color: .customF5C1FF.opacity(0.40), radius: 26, x: 0, y: 5)
        
    }
    
    func getListAlarmSection() -> some View {
        VStack(spacing: 10) {
            HStack {
                Text("List of Alarms")
                    .font(.getFont(.bold, size: 20))
                    .foregroundStyle(.custom2D2D40)
                Spacer()
            }
            
            ForEach(0..<5) { index in
                AlarmItemView()
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeView(path: .constant([]))
}
