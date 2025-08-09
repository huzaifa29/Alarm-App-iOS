//
//  FrequencyView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct FrequencyData: Identifiable {
    var id: String
    var text: String
    var isSelected: Bool
}

struct FrequencyView: View {
    var title: String
    var titleFont: Font = .getFont(.semiBold, size: 20)
    var titleColor = Color.custom2D2D40
    var titleHeight: CGFloat = 32

    @Binding var arrayItems: [FrequencyData]
    @State var selectedIndex: Int? = nil
    var isMultiSelectionEnabled = false
    
    @Environment(\.displayScale) var displayScale
    let screenWidth = UIScreen.main.bounds.width
    @State var itemsInFirstRow = 4
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(titleFont)
                    .foregroundStyle(titleColor)
                    .frame(height: titleHeight)
                
                if arrayItems.count >= itemsInFirstRow {
                    // First row (3 columns)
                    HStack(spacing: 8) {
                        ForEach(0..<min(arrayItems.count, itemsInFirstRow), id: \.self) { index in
                            FrequencyItemView(dataModel: arrayItems[index])
                                .onTapGesture {
                                    handleSelection(index)
                                }
                        }
                    }
                }
                
                if arrayItems.count > itemsInFirstRow {
                    // Second row (4 columns)
                    HStack(spacing: 8) {
                        ForEach(itemsInFirstRow..<arrayItems.count, id: \.self) { index in
                            FrequencyItemView(dataModel: arrayItems[index])
                                .onTapGesture {
                                    handleSelection(index)
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            print(displayScale)
            if screenWidth >= 287 {
                itemsInFirstRow = 4
            } else {
                itemsInFirstRow = 3
            }
        }
    }

    private func handleSelection(_ index: Int) {
        if isMultiSelectionEnabled {
            arrayItems[index].isSelected.toggle()
        } else {
            if let selected = selectedIndex {
                arrayItems[selected].isSelected = false
            }
            arrayItems[index].isSelected = true
            selectedIndex = index
        }
    }
}


#Preview {
    FrequencyView(title: "Frequency", arrayItems: .constant(getWeekDay()))
}

func getWeekDay() -> [FrequencyData] {
    var weekDay = [FrequencyData]()
    for day in Locale.autoupdatingCurrent.orderedWeekdays {
        weekDay.append(.init(id: day.rawValue, text: day.fullDayName, isSelected: false))
    }
    return weekDay
}
