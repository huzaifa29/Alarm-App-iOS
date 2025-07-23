//
//  FrequencyView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct FrequencyView: View {
    let columns = [
        GridItem(.adaptive(minimum: 90), spacing: 0)
    ]
    
    var title: String
    var titleFont: Font = .getFont(.semiBold, size: 20)
    var titleColor = Color.custom2D2D40
    var titleHeight: CGFloat = 32
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(titleFont)
                .foregroundStyle(titleColor)
                .frame(height: titleHeight)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(0..<5) { index in
                    FrequencyItemView(text: "Every Day")
                }
            }
            
        }
    }
}

#Preview {
    FrequencyView(title: "Frequency")
}
