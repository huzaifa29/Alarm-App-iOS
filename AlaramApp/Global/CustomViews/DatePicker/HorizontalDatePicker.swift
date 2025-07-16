//
//  HorizontalDatePicker.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct HorizontalDatePicker: View {
    @Binding var selectedDate: Date
    let dateRange: [Date]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(dateRange, id: \.self) { date in
                    dateButton(for: date)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 66)
    }
    
    private func dateButton(for date: Date) -> some View {
        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
        return Button(action: {
            selectedDate = date
        }) {
            VStack(spacing: 4) {
                Text(date, format: .dateTime.day())
                    .font(.getFont(.extraBold, size: 16))
                    .foregroundStyle(isSelected ? .white : Color(.custom2D2D40))
                
                
                Text(date, format: .dateTime.weekday(.abbreviated))
                    .font(.getFont(.medium, size: 12))
                    .foregroundStyle(isSelected ? .white : Color(.custom9A6C8D))
                
            }
            .frame(width: 46, height: 66)
            .background(
                Capsule()
                    .fill(isSelected ? .red : (Color(.customFFEBF7)))
            )
        }
        .buttonStyle(.plain)
    }
    
}

extension Date {
    static func nextNDays(_ count: Int) -> [Date] {
        let calendar = Calendar.current
        return (0..<count).compactMap {
            calendar.date(byAdding: .day, value: $0, to: Date())
        }
    }
}
