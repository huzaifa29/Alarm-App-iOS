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
    let columns = [
        GridItem(.adaptive(minimum: 90), spacing: 0)
    ]
    
    var title: String
    var titleFont: Font = .getFont(.semiBold, size: 20)
    var titleColor = Color.custom2D2D40
    var titleHeight: CGFloat = 32
    @Binding var arrayItems: [FrequencyData]
    @State var selectedIndex: Int? = nil
    var isMultiSelectionEnabled = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(titleFont)
                .foregroundStyle(titleColor)
                .frame(height: titleHeight)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(0..<arrayItems.count, id: \.self) { index in
                    FrequencyItemView(dataModel: arrayItems[index])
                        .onTapGesture {
                            if isMultiSelectionEnabled {
                                arrayItems[index].isSelected.toggle()
                            } else {
                                if let selectedIndex = selectedIndex {
                                    arrayItems[selectedIndex].isSelected = false
                                }
                                arrayItems[index].isSelected = true
                                selectedIndex = index
                            }
                        }
                }
            }
            
        }
    }
}

#Preview {
    FrequencyView(title: "Frequency", arrayItems: .constant([]))
}
