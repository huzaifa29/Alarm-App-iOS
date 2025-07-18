//
//  ContentView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 14/07/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModelImpl
    
    var body: some View {
        getViewForState(viewModel: viewModel)
            .animation(.easeInOut, value: viewModel.state)
            .onAppear {
                print("Content View")
            }
    }
}

@MainActor @ViewBuilder
func getViewForState(viewModel: AuthViewModelImpl) -> some View {
    switch viewModel.state {
    case .launch:
        LaunchView()
            .transition(.opacity)
    case .onboarding:
        OnboardingView(data: Onboarding.data)
            .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
    case .signin:
        SigninView(supabase: .shared)
            .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
    }
}

#Preview {
    ContentView()
}
