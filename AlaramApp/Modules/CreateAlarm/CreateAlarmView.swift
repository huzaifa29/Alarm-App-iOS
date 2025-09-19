//
//  CreateAlarmView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct CreateAlarmView: View {
    @State private var isToggleOn = true
    @State private var selectedSegment = 0
    
    let options = ["Time", "Detail"]
    
    @Binding var path: [HomeRoute]
    @State var alarmData: AlarmForm
    
    var body: some View {
        ZStack {
            PrimaryBackground()
            
            VStack(spacing: 0) {
                TopBarView<HomeRoute>(path: $path)
                
                HStack {
                    Text("Create Alarm")
                        .font(.getFont(.bold, size: 20))
                        .foregroundStyle(.custom2D2D40)
                    
                    Spacer()
                    
                    HStack {
                        Text("Quick Alarm")
                            .font(.getFont(.regular, size: 10))
                            .foregroundStyle(.custom2D2D40)
                        
                        CustomToggle(isOn: $isToggleOn, onColor: .white, offColor: .white, knobColor: .white)
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                CustomSegmentedControl(selectedIndex: $selectedSegment, titles: options)
                    .frame(height: 56)
                    .padding([.horizontal, .top], 20)
                
                switch selectedSegment {
                case 0:
                    TimeView(selectedHour: alarmData.selectedHour, selectedMinute: alarmData.selectedMinute, alarmNote: alarmData.desc) { hour, minute, note in
                        alarmData.selectedHour = hour
                        alarmData.selectedMinute = minute
                        alarmData.desc = note
                        selectedSegment = 2
                    }
                    
                case 1:
                    EmptyView()
                    
                case 2:
                    DetailView(alarmName: alarmData.title) { alarmName, selectedDays in
                        alarmData.title = alarmName
                        alarmData.selectedDays = selectedDays
                        
                        self.path.append(.previewAlarm(data: alarmData))
                    }
                    
                default:
                    EmptyView()
                }
                
                Spacer()
                
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CreateAlarmView(path: .constant([]), alarmData: .init())
}
