//
//  Locale+Extension.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 26/07/2025.
//

import Foundation

extension Locale {
    var orderedWeekdays: [Locale.Weekday] {
        let days: [Locale.Weekday] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        if let firstDayIdx = days.firstIndex(of: firstDayOfWeek), firstDayIdx != 0 {
            return Array(days[firstDayIdx...] + days[0..<firstDayIdx])
        }
        return days
    }
}

extension Locale.Weekday {
    var fullDayName: String {
        switch self {
        case .sunday:
            return "Sunday"
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        @unknown default:
            fatalError()
        }
    }
    
    var sortValue: Int {
        switch self {
        case .sunday:
            return 0
        case .monday:
            return 1
        case .tuesday:
            return 2
        case .wednesday:
            return 3
        case .thursday:
            return 4
        case .friday:
            return 5
        case .saturday:
            return 6
        @unknown default:
            fatalError()
        }
    }
}
