//
//  GoogleSignInViewController.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 26/07/2025.
//

import UIKit
import GoogleSignIn
import Supabase

class GoogleSignInViewController: UIViewController {
    var onSignedIn: ((Bool, String?) -> Void)?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            do {
                try await googleSignIn()
                onSignedIn?(true, nil)
            } catch {
                print(error)
                onSignedIn?(false, error.localizedDescription)
            }
        }
    }
    
    func googleSignIn() async throws {
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: self)
        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(domain: "SignIn", code: 0, userInfo: [NSLocalizedDescriptionKey: "No idToken found."])
        }
        let accessToken = result.user.accessToken.tokenString
        try await SupabaseManager.shared.client.auth.signInWithIdToken(
            credentials: OpenIDConnectCredentials(
                provider: .google,
                idToken: idToken,
                accessToken: accessToken
            )
        )
    }

}
