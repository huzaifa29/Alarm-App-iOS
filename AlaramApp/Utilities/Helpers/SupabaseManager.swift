//
//  SupabaseManager.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import Foundation
import Supabase

class SupabaseManager {
    
    let supabase: SupabaseClient
    let url = "https://oxcyvjamnyxdohilcquv.supabase.co"
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94Y3l2amFtbnl4ZG9oaWxjcXV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI3NDQwNzAsImV4cCI6MjA2ODMyMDA3MH0.llTEohO1iWRjlDrEyqLXLFz59cOr0pDw3wTcGI-fNdM"
    
    static let shared = SupabaseManager()
    
    var user: User?
    var errorMessage: String?
    
    fileprivate init() {
        supabase = SupabaseClient(supabaseURL: URL(string: url)!, supabaseKey: apiKey)
    }
    
    func getAuth() -> AuthClient {
        return supabase.auth
    }
    
    func signUp(email: String, password: String, name: String, language: String) async -> Bool {
        errorMessage = nil
        do {
            let session = try await supabase.auth.signUp(
                email: email,
                password: password,
                data: [
                    "name": .string(name),
                    "language": .string(language)
                ]
            )
            self.user = session.user
            self.errorMessage = nil
            return true
        } catch {
            self.user = nil
            self.errorMessage = error.localizedDescription
            return false
        }
    }
    
    func signIn(email: String, password: String) async -> Bool {
        errorMessage = nil
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            self.user = session.user
            self.errorMessage = nil
            return true
        } catch {
            self.user = nil
            self.errorMessage = error.localizedDescription
            return false
        }
    }
    
    func resetPassword(email: String) async -> Bool {
        do {
            try await supabase.auth.resetPasswordForEmail(email)
            self.errorMessage = nil
            return true
        } catch {
            self.errorMessage = error.localizedDescription
            return false
        }
    }
}
