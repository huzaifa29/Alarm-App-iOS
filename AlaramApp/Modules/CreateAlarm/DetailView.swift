//
//  DetailView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct DetailView: View {
    @Binding var path: [HomeRoute]
    
    @State private var alarmName: String = ""
    
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
            
            FrequencyView(title: "Frequency model")
            
            FrequencyView(title: "Repeat on")
            
            Spacer()
            
            PrimaryButton(text: "Save Details") {
                self.path.append(.previewAlarm)
            }
            .padding(.top, 20)
            
        }
        .padding([.horizontal, .top], 20)
    }
}

#Preview {
    DetailView(path: .constant([]))
}
