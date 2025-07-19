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
            HStack(spacing: 10) {
                ForEach(dateRange, id: \.self) { date in
                    dateButton(for: date)
                        .padding(.vertical, 30)
                }
            }
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
                Group {
                    if isSelected {
                        getSelectedBackgroundView()
                            .padding(.vertical, 30)
                    } else {
                        Capsule()
                            .fill((Color(.customFFEBF7)))
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }
    
}

extension HorizontalDatePicker {
    func getSelectedBackgroundView() -> some View {
        ZStack {
            // Outer shadow (glow)
            Capsule()
                .fill(Color.clear)
                .background(
                    Capsule()
                        .fill(Color(.customF5C1FF).opacity(0.7))
                        .blur(radius: 15.3)
                        .offset(y: 15) // mimic 15px shadow with ~7pt offset
                )
                .frame(width: 46, height: 66)
            
            // Main capsule with background + inset inner glow + border
            Capsule()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(.customABA3F4),
                            Color(.customF5B3FF)
                        ]),
                        startPoint: .init(x: 0.17, y: 0), // ~199.07°
                        endPoint: .bottom
                    )
                )
                .overlay(
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(.customF6C5FE),
                                    Color.white
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                )
            // Inset shadow simulation (white glow inside top-left)
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.5), lineWidth: 7)
                        .blur(radius: 7)
                        .offset(x: -6, y: 6)
                        .mask(Capsule())
                )
                .frame(width: 46, height: 66)
        }
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
