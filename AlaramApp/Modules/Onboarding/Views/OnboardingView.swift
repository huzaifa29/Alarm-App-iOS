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
                ForEach(0..<data.count, id: \.self) { index in
                    OnboardingItemView(item: data[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: selectedTab)
            
            HStack(spacing: 5) {
                ForEach(0..<data.count, id: \.self) { index in
                    Capsule()
                        .fill(index == selectedTab ? Color(.customA067D0) : Color(.customD8C0E6))
                        .frame(width: index == selectedTab ? 37 : 10, height: 3)
                        .animation(.spring(), value: selectedTab)
                }
            }
            
            Group {
                PrimaryButton(text: selectedTab == 2 ? "Finish" : "Next") {
                    withAnimation {
                        if selectedTab != 2 {
                            selectedTab += 1
                        } else {
                            viewModel.updateState()
                        }
                    }
                }
                
                Button {
                    viewModel.updateState()
                } label: {
                    Text(selectedTab == 2 ? "" : "Skip")
                        .font(Font.getFont(.bold, size: 16))
                        .foregroundStyle(Color(.custom2D2D40))
                }
                .frame(height: 26)
                .disabled(selectedTab == 2)
                
            }
            .padding(.horizontal, 20)
            
        }
        .padding(.bottom, 42)
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    OnboardingView(data: Onboarding.data)
}
