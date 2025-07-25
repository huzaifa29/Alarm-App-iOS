//
//  Tab.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import SwiftUI

enum Tab: Int, CaseIterable {
    case home, alarm
    
    var icon: String {
        switch self {
        case .home: return "ic_home_tab"
        case .alarm: return "ic_clock_tab"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .home: return "ic_home_tab_selected"
        case .alarm: return "ic_clock_tab_selected"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .alarm: return "Alarm"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return .red
        case .alarm: return .blue
        }
    }
}
