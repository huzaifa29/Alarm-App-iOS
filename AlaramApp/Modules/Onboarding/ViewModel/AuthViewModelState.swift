//
//  AuthViewModelState.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import Foundation

enum AuthViewModelState {
    case launch
    case onboarding // Onboarding screen
    case registeredUser // Logged in with Apple and registered on Firestore
    case permission 
}
