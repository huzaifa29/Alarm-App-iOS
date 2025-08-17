//
//  AlarmModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 27/07/2025.
//

import Foundation

struct AlarmModel: Codable, Hashable {
    var id: String = UUID().uuidString
    let userId: String
    let musicId: String?
    let name: String?
    let description: String?
    let type: String?
    let selectedDays: [String]?
    let time: Date?
    let createdAt: Date?
    var music: MusicModel? = nil
    var voiceName: String?
    var voiceURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case musicId = "music_id"
        case name
        case description
        case type
        case selectedDays = "selected_days"
        case time
        case createdAt = "created_at"
        case music
        case voiceName = "voice_name"
        case voiceURL = "voice_url"
    }
    
    init(userId: String, musicId: String?, name: String?, description: String?, type: String?, selectedDays: [String]?, time: Date?, createdAt: Date?, voiceName: String?, voiceURL: String?) {
        self.userId = userId
        self.musicId = musicId
        self.name = name
        self.description = description
        self.type = type
        self.selectedDays = selectedDays
        self.time = time
        self.createdAt = createdAt
        self.voiceName = voiceName
        self.voiceURL = voiceURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? UUID().uuidString
        musicId = try container.decodeIfPresent(String.self, forKey: .musicId) ?? UUID().uuidString
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        selectedDays = try container.decodeIfPresent([String].self, forKey: .selectedDays)
        time = try container.decodeIfPresent(Date.self, forKey: .time)
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        music = try container.decodeIfPresent(MusicModel.self, forKey: .music)
        voiceName = try container.decodeIfPresent(String.self, forKey: .voiceName)
        voiceURL = try container.decodeIfPresent(String.self, forKey: .voiceURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(musicId, forKey: .musicId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(selectedDays, forKey: .selectedDays)
        try container.encodeIfPresent(time, forKey: .time)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(voiceName, forKey: .voiceName)
        try container.encodeIfPresent(voiceURL, forKey: .voiceURL)
    }
    
    func getFormattedTime() -> String? {
        guard let time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: time)
    }
    
    func getSelectedDays() -> [FrequencyData] {
        guard let selectedDays else { return [] }
        return selectedDays.map {
            return FrequencyData(id: UUID().uuidString, text: $0, isSelected: false)
        }
    }
}
