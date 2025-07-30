//
//  SupabaseManager.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import Foundation
import Supabase

class SupabaseManager {
    
    let client: SupabaseClient
    let url = "https://oxcyvjamnyxdohilcquv.supabase.co"
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94Y3l2amFtbnl4ZG9oaWxjcXV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI3NDQwNzAsImV4cCI6MjA2ODMyMDA3MH0.llTEohO1iWRjlDrEyqLXLFz59cOr0pDw3wTcGI-fNdM"
    
    static let shared = SupabaseManager()
    
    var user: User?
    var errorMessage: String?
    
    fileprivate init() {
        client = SupabaseClient(supabaseURL: URL(string: url)!, supabaseKey: apiKey)
    }
    
    func checkSession() async -> Bool {
        do {
            let session = try await client.auth.session
            self.user = session.user
            return true
        } catch {
            return false
        }
    }
    
    func getAuth() -> AuthClient {
        return client.auth
    }
    
    func signUp(email: String, password: String, name: String, language: String) async throws -> Error? {
        do {
            let session = try await client.auth.signUp(
                email: email,
                password: password,
                data: [
                    "name": .string(name),
                    "language": .string(language)
                ]
            )
            self.user = session.user
            return nil
        } catch {
            self.user = nil
            return error
        }
    }
    
    func signIn(email: String, password: String) async -> Bool {
        errorMessage = nil
        do {
            let session = try await client.auth.signIn(email: email, password: password)
            self.user = session.user
            AppDefaults.isLogin = true
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
            try await client.auth.resetPasswordForEmail(email)
            self.errorMessage = nil
            return true
        } catch {
            self.errorMessage = error.localizedDescription
            return false
        }
    }
}

// MARK: - Tables
extension SupabaseManager {
    func fetchTable<T: Decodable>(table: SupabaseTable, select: String = "*", filters: [String: Any] = [:], as type: T.Type) async -> [T]? {
        self.errorMessage = nil
        do {
            var query = client
                .schema("public")
                .from(table.rawValue)
                .select(select)

            for (key, value) in filters {
                if let stringValue = value as? String {
                    query = query.eq(key, value: stringValue)
                } else if let intValue = value as? Int {
                    query = query.eq(key, value: intValue)
                } else if let boolValue = value as? Bool {
                    query = query.eq(key, value: boolValue)
                } else {
                    print("Unsupported filter type for key: \(key)")
                }
            }

            let response = try await query.execute()
            return try decode(response.data, as: [T].self)
        } catch {
            self.errorMessage = error.localizedDescription
            return []
        }
    }

    
    func insert<T: Codable>(table: SupabaseTable, model: T) async throws -> Error? {
        do {
            let response = try await client
                .schema("public")
                .from(table.rawValue)
                .insert([model])
                .execute()
            
            print("Record created successfully: \(response)")
            return nil
        } catch {
            print("Insert error: \(error.localizedDescription)")
            return error
        }
    }
    
    // Generic decoder method
    func decode<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode(T.self, from: data)
    }
    
    
}
