//
//  LoaderView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 18/07/2025.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        Color.black.opacity(0.1)
            .ignoresSafeArea()
        
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.custom2D2D40)
            .scaleEffect(2.5)
    }
}

#Preview {
    LoaderView()
}
