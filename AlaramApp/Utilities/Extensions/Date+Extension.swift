//
//  DateExt.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 26/07/2025.
//

import Foundation

extension Date {
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    func replacing(hour: Int, minute: Int) -> Date? {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }
}

