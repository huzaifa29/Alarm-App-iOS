//
//  CustomToggle.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import SwiftUI

struct CustomToggle: View {
    @Binding var isOn: Bool
    
    var onColor: Color = Color.green
    var offColor: Color = Color.gray
    var knobColor: Color = Color.white
    var width: CGFloat = 31
    var height: CGFloat = 17
    var padding: CGFloat = 4
    
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: height / 2)
                .fill(isOn ? onColor : offColor)
                .frame(width: width, height: height)
                .animation(.easeInOut(duration: 0.25), value: isOn)
            
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(.custom7E71FF), Color(.customE852FF)]), startPoint: .top, endPoint: .bottom)
                )
                .frame(width: height - padding * 2, height: height - padding * 2)
                .padding(.all, padding)
                .shadow(radius: 1)
        }
        .onTapGesture {
            isOn.toggle()
        }
    }
}
