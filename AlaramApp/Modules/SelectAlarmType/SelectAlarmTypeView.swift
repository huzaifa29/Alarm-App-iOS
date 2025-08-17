//
//  SelectAlarmTypeView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 22/07/2025.
//

import SwiftUI

struct SelectAlarmTypeView: View {
    @Binding var path: [HomeRoute]
    
    @State var arrayAlarmType: [AlarmTypeItemView.DataModel] = [
        .init(image: "ic_music", title: "Basic Alarm", desc: "You can choose music from library or can upload your favorite music in app library, set time to wake up and get tension free.", isSelected: false),
        .init(image: "ic_microphone", title: "Customized voice alarm creation", desc: "Record your custom voice for peaceful morning, save your recording for later use add time and set alarm.", isSelected: false),
        .init(image: "ic_message_text", title: "Text to speech alarm creation", desc: "Enter your text, select your favorite voice from character list and you can preview tune and set alarm for your special day.", isSelected: false)
    ]
    @State var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Select your alarm style")
            
            ForEach(0..<arrayAlarmType.count, id: \.self) { index in
                AlarmTypeItemView(dataModel: arrayAlarmType[index])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        arrayAlarmType[selectedIndex].isSelected = false
                        arrayAlarmType[index].isSelected = true
                        selectedIndex = index
                        
                        switch index {
                        case 0:
                            self.path.append(.musicLibrary)
                        case 1:
                            self.path.append(.audioRecord)
                        case 2:
                            break
                        default:
                            break
                        }
                    }
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SelectAlarmTypeView(path: .constant([]))
}

