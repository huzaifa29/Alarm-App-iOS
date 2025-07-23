//
//  PrimaryBackground.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/07/2025.
//

import SwiftUI

struct PrimaryBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.customFFF5FB, .customFFF5FB]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    PrimaryBackground()
}
