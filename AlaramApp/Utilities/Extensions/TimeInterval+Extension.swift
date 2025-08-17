//
//  TimeInterval+Extension.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 26/07/2025.
//

import Foundation

extension TimeInterval {
    func customFormatted() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self) ?? self.formatted()
    }
    
    func secondsString() -> String {
        return String(format: "%02d", getSeconds())
    }
    
    func getSeconds() -> Int {
        let intVal = Int(self)
        let seconds = intVal % 60
        return seconds
    }
}
