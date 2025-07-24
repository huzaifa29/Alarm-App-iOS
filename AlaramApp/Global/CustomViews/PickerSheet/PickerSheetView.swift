//
//  PickerSheetView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import SwiftUI

struct PickerSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var range: Range<Int>
    @Binding var selection: Int
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(.getFont(.medium, size: 20))
                .padding(.top)
            
            Picker("", selection: $selection) {
                ForEach(range, id: \.self) { value in
                    Text(String(format: "%02d", value)).tag(value)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(height: 200)
            
            Spacer()
            
            PrimaryButton(text: "Done") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}
