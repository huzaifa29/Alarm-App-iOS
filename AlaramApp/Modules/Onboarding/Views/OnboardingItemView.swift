//
//  OnboardingItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 15/07/2025.
//

import SwiftUI

struct OnboardingItemView: View {
    var item: Onboarding
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .top)
                
                VStack {
                    Spacer()
                    Text(item.title)
                        .font(Font.getFont(.semiBold, size: 30))
                        .foregroundStyle(.white)
                        .frame(width: 251)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 20)
            }
            
            Text(item.description)
                .font(Font.getFont(.medium, size: 18))
                .foregroundStyle(Color(.custom433261))
                .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingItemView(item: Onboarding.data.first!)
}
