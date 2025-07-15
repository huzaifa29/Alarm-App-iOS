//
//  Onboarding.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct Onboarding: Identifiable {
    var id: Int
    var title: String
    var description: String
    var image: String
    
    static var data: [Onboarding] = [Onboarding(id: 0,
                                                title: "Smarter Waking, Made Simple",
                                                description: "Record your voice, type a message, or pick a favorite tune — your alarm, your style.",
                                                image: "onboarding1"),
                                     
                                     Onboarding(id: 1,
                                                title: "Your Daily Boost",
                                                description: "Customize when and how you wake up — daily, weekly, or just tomorrow morning.",
                                                image: "onboarding2"),
                                     
                                     Onboarding(id: 2,
                                                title: "Why You'll Love This",
                                                description: "Send your alarm to a friend or share it online — your morning vibes can go viral.",
                                                image: "onboarding3")]
}

