//
//  CustomAlarmMetaData.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 26/07/2025.
//


import AlarmKit

nonisolated struct CustomAlarmMetaData: AlarmMetadata {
    let createdAt: Date
    let method: Method?
    
    init(method: Method? = nil) {
        self.createdAt = Date.now
        self.method = method
    }
    
    enum Method: String, Codable {
        case stove
        case grill
        case oven
        case fry
        case chill
        
        var icon: String {
            switch self {
            case .stove: "stove"
            case .grill: "fire"
            case .oven: "oven"
            case .fry: "frying.pan"
            case .chill: "snowflake"
            }
        }
    }
}
