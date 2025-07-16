//
//  OnboardingView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 15/07/2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: AuthViewModelImpl
    
    @State private var selectedTab: Int = 0
    
    var data: [Onboarding]
    
    var body: some View {
        VStack(spacing: 20) {
            TabView(selection: $selectedTab) {
                ForEach(0 ..< data.count) { index in
                    OnboardingItemView(item: data[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
//            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            VStack(spacing: 20) {
                PrimaryButton(text: selectedTab == 2 ? "Finish" : "Next") {
                    if selectedTab != 2 {
                        selectedTab += 1
                    } else {
                        viewModel.updateState()
                    }
                }
                
                if selectedTab == 2 {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 25)
                    
                } else {
                    Button {
                        viewModel.updateState()
                    } label: {
                        Text("Skip")
                            .font(Font.getFont(.bold, size: 16))
                            .foregroundStyle(Color(.custom2D2D40))
                    }
                    .frame(height: 26)
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 52)
        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    OnboardingView(data: Onboarding.data)
}
