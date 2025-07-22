//
//  TopBarView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 22/07/2025.
//

import SwiftUI

struct TopBarView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var title: String?
    
    var body: some View {
        HStack(spacing: 15) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(.icBack)
                    .resizable()
                    .frame(width: 30, height: 30)
            }

            if let title = title {
                Text(title)
                    .foregroundStyle(.custom2D2D40)
                    .font(.getFont(.bold, size: 18))
            }
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal, 20)
    }
}

#Preview {
    TopBarView(title: "Test")
}
