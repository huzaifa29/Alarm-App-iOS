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
    
    func updateState() {
        switch state {
        case .launch:
            configureCurrentState()
        case .onboarding:
            state = .signin
        default:
            print("")
        }
    }
}

// MARK: -
private extension AuthViewModelImpl {
    func configureCurrentState() {
        let onboardingShown = AppDefaults.onboardingShown
        state = onboardingShown ? .signin : .onboarding
    }
}
