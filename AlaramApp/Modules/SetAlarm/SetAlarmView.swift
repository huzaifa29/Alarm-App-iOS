//
//  SetAlarmView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/07/2025.
//

import SwiftUI

struct SetAlarmView: View {
    @State private var alarmViewModel = AlarmViewModel()
    
    @State private var selectedHour: Int = 6
    @State private var selectedMinute: Int = 30
    @State private var repeatDays: String = ""
    @State private var isLoading = false
    
    @Binding var path: [HomeRoute]
    @State var alarmData: AlarmForm
    let supabase: SupabaseManager
    
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
                        TimerPickerView(selectedHour: $selectedHour, selectedMinute: $selectedMinute)
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
                            
                            Text(alarmData.musicData?.name ?? "")
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
                        
                        Text(repeatDays)
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
                    Task {
                        let isSuccess = await alarmViewModel.requestAuthorization()
                        if isSuccess {
                            self.callCreateAlarm()
                        }
                    }
                }
                .padding([.horizontal, .top], 20)
            }
        }
        .onAppear {
            selectedHour = alarmData.selectedHour
            selectedMinute = alarmData.selectedMinute
            let sortedDays = alarmData.selectedDays.sorted { return $0.sortValue < $1 .sortValue }
            for day in sortedDays {
                repeatDays += day.fullDayName + ", "
            }
            if !repeatDays.isEmpty {
                repeatDays.removeLast(2)
            }
        }
        .loader(isLoading: isLoading)
        .navigationBarHidden(true)
    }
}

// MARK: - Methods
extension SetAlarmView {
    func callCreateAlarm() {
        Task {
            isLoading = true
            let selectedDays = alarmData.selectedDays.map({ return $0.fullDayName })
            let alarmTime = Date().replacing(hour: selectedHour, minute: selectedMinute)!
            
            print(supabase.user?.id.uuidString)
            print(alarmData.musicData?.id)
            
            let alarmModel = AlarmModel(userId: supabase.user?.id.uuidString ?? "",
                                        musicId: alarmData.musicData?.id ?? "",
                                        name: alarmData.title,
                                        description: alarmData.desc,
                                        type: alarmData.type.rawValue,
                                        selectedDays: selectedDays,
                                        time: alarmTime,
                                        createdAt: .now)
            await supabase.insert(table: "alarms", model: alarmModel)
            self.isLoading = false
            if supabase.errorMessage == nil {
                alarmData.selectedHour = selectedHour
                alarmData.selectedMinute = selectedMinute
                alarmData.selectedDate = alarmTime
                alarmData.scheduleEnabled = true
                alarmViewModel.scheduleAlarm(with: alarmData)
                self.path.removeAll()
            }
        }
    }
}

#Preview {
    SetAlarmView(path: .constant([]), alarmData: .init(), supabase: .shared)
}
