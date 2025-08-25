//
//  MessageAlertModifier.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/08/2025.
//

import SwiftUI

struct MessageAlertModifier: ViewModifier {
    @Binding var alertData: AlertData
    
    func body(content: Content) -> some View {
        content
            .alert(
                alertData.title.isEmpty ? alertData.message : alertData.title,
                isPresented: Binding(
                    get: { alertData.isPresented },
                    set: { if !$0 { alertData.dismiss() } }
                )
            ) {
                Button("OK", role: .cancel) {
                    alertData.dismiss()
                }
            } message: {
                if !alertData.title.isEmpty {
                    Text(alertData.message)
                }
            }
    }
}

extension View {
    func messageAlert(_ alertData: Binding<AlertData>) -> some View {
        self.modifier(MessageAlertModifier(alertData: alertData))
    }
}
