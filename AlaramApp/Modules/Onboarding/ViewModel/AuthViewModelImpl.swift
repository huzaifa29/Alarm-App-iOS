//
//  AuthViewModelImpl.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

@MainActor
class AuthViewModelImpl: ObservableObject {
    @Published var state: AuthViewModelState = .launch
    let supabase: SupabaseManager = SupabaseManager.shared
    
    func updateState() {
        switch state {
        case .launch:
            configureCurrentState()
        case .onboarding:
            state = .signin
        default:
            print("Not found")
        }
    }
}

// MARK: -
private extension AuthViewModelImpl {
    func configureCurrentState() {
        if AppDefaults.isLogin {
            Task {
                let success = await supabase.checkSession()
                if success {
                    state = .tabbar
                } else {
                    state = .signin
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let onboardingShown = AppDefaults.onboardingShown
                self.state = onboardingShown ? .signin : .onboarding
            }
        }
    }
}
