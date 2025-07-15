//
//  AppDefaults.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

class AppDefaults: UserDefaults {
    static var shared = AppDefaults()

    override class var standard: UserDefaults {
        return UserDefaults.standard
    }

    static func clearUserDefaults() {
        AppDefaults.onboardingShown = false
        AppDefaults.permissionScreenShown = false
    }
    
    static var onboardingShown: Bool {
        get { AppDefaults[#function] ?? false }
        set { AppDefaults[#function] = newValue }
    }
    
    static var permissionScreenShown: Bool {
        get { AppDefaults[#function] ?? false }
        set { AppDefaults[#function] = newValue }
    }
    
    static var scheduleActivities: Set<String> {
        get { AppDefaults[#function] ?? [] }
        set { AppDefaults[#function] = newValue }
    }
    
    static var isDefaultSchedularSaved: Bool {
        get { AppDefaults[#function] ?? false }
        set { AppDefaults[#function] = newValue }
    }
    
    static var selectedDailyLimit: Int? {
        get { AppDefaults[#function] }
        set { AppDefaults[#function] = newValue }
    }
}

extension AppDefaults {
    static subscript<T: Codable>(key: String) -> T? {
        get { AppDefaults.shared.getValue(key) }
        set(newValue) { AppDefaults.shared.setValue(newValue, for: key) }
    }

    fileprivate func getValue<T: Codable>(_ key: String) -> T? {
        guard let data = AppDefaults.standard.data(forKey: key) else { return nil }
        return decode(data).0
    }

    fileprivate func setValue<T: Codable>(_ value: T, for key: String) {
        let decoded = encode(value)
        if let data = decoded.data {
            AppDefaults.standard.set(data, forKey: key)
            AppDefaults.standard.synchronize()
        } else {
            print("Value not set for \(key): \(decoded.error?.localizedDescription ?? "")")
        }
    }
}
