//
//  GoogleSignInWrapper.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 26/07/2025.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInWrapper: UIViewControllerRepresentable {
    let onSignedIn: (Bool, String?) -> Void

    func makeUIViewController(context: Context) -> GoogleSignInViewController {
        let controller = GoogleSignInViewController()
        controller.onSignedIn = onSignedIn
        return controller
    }

    func updateUIViewController(_ uiViewController: GoogleSignInViewController, context: Context) { }
}
