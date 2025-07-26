//
//  AlarmModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 27/07/2025.
//

import Foundation

struct AlarmModel: Codable, Hashable {
    var id: String = UUID().uuidString
    let userId: String?
    let musicId: String?
    let name: String?
    let description: String?
    let musicName: String?
    let musicUrl: String?
    let musicThumbnail: String?
    let time: Date?
    let selectedDays: String?
    let type: String?
    let createdAt: Date?
    var isEnabled: Bool? = true
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case musicId = "music_id"
        case name
        case description
        case musicName = "music_name"
        case musicUrl = "music_url"
        case musicThumbnail = "music_thumbnail"
        case time
        case selectedDays = "selected_days"
        case type
        case createdAt = "created_at"
        case isEnabled = "is_enabled"
    }
    
    func getFormattedTime() -> String? {
        guard let time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: time)
    }
    
    func getSelectedDays() -> [FrequencyData] {
        guard let selectedDays else { return [] }
        return selectedDays.components(separatedBy: ",").map {
            return FrequencyData(id: UUID().uuidString, text: $0, isSelected: false)
        }
    }
}
