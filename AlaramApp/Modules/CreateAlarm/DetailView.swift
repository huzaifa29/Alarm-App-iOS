//
//  DetailView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct DetailView: View {
    @State var alarmName: String = ""
    @State private var arrayDays = [FrequencyData]()
    
    var onSaveDetails: ((_ alarmName: String, _ selectedDays: Set<Locale.Weekday>) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Finalize your alarm")
                .font(.getFont(.bold, size: 20))
                .foregroundStyle(.custom2D2D40)
            
            TextField("Name your alarm here", text: $alarmName)
                .font(.getFont(.medium, size: 14))
                .foregroundStyle(.customCDA9C3)
                .padding(.horizontal, 15)
                .padding(.top, 11)
                .padding(.bottom, 18)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.customFFF6FB)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(LinearGradient(colors: [.white.opacity(0), .white, .white.opacity(0)], startPoint: .top, endPoint: .bottom), lineWidth: 1.5)
                        )
                )
                .frame(height: 53)
                .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 0)
            
            FrequencyView(title: "Repeat on", arrayItems: $arrayDays, isMultiSelectionEnabled: true)
            
            Spacer()
            
            PrimaryButton(text: "Save Details") {
                let selectedDays = Set(arrayDays.filter{ $0.isSelected }.compactMap { Locale.Weekday(rawValue: $0.text) })
                onSaveDetails?(alarmName, selectedDays)
            }
            .padding(.top, 20)
            
        }
        .padding([.horizontal, .top], 20)
        .onAppear {
            if arrayDays.isEmpty {
                for day in Locale.autoupdatingCurrent.orderedWeekdays {
                    arrayDays.append(.init(text: day.rawValue, isSelected: false))
                }
            }
        }
    }
}

#Preview {
    DetailView()
}
