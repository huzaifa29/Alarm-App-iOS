//
//  LoaderModifier.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 27/07/2025.
//

import SwiftUI

struct LoaderModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.custom2D2D40)
                    .scaleEffect(2.5)
            }
        }
    }
}

extension View {
    func loader(isLoading: Bool) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
