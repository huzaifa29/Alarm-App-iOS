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
    let speechId: String?
    let name: String?
    let description: String?
    let type: String?
    let selectedDays: [String]?
    let time: Date?
    let createdAt: Date?
    var audioName: String?
    var audioURL: String?
    var speech: SpeechModel? = nil
    var ttsVoiceId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case speechId = "speech_id"
        case name
        case description
        case type
        case selectedDays = "selected_days"
        case time
        case createdAt = "created_at"
        case audioName = "audio_name"
        case audioURL = "audio_url"
        case speech
        case ttsVoiceId = "tts_voice_id"
    }
    
    init(userId: String, alarmData: AlarmForm?, selectedDays: [String]?, time: Date?) {
        self.userId = userId
        self.speechId = alarmData?.speechData?.id
        self.name = alarmData?.title
        self.description = alarmData?.desc
        self.type = alarmData?.type.rawValue
        self.selectedDays = selectedDays
        self.time = time
        self.createdAt = .now
        self.audioName = alarmData?.audioName
        self.audioURL = alarmData?.audioURL
        self.ttsVoiceId = alarmData?.voiceData?.voiceId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? UUID().uuidString
        speechId = try container.decodeIfPresent(String.self, forKey: .speechId) ?? UUID().uuidString
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        selectedDays = try container.decodeIfPresent([String].self, forKey: .selectedDays)
        time = try container.decodeIfPresent(Date.self, forKey: .time)
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        audioName = try container.decodeIfPresent(String.self, forKey: .audioName)
        audioURL = try container.decodeIfPresent(String.self, forKey: .audioURL)
        speech = try container.decodeIfPresent(SpeechModel.self, forKey: .speech)
        ttsVoiceId = try container.decodeIfPresent(String.self, forKey: .ttsVoiceId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(speechId, forKey: .speechId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(selectedDays, forKey: .selectedDays)
        try container.encodeIfPresent(time, forKey: .time)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(audioName, forKey: .audioName)
        try container.encodeIfPresent(audioURL, forKey: .audioURL)
        try container.encodeIfPresent(ttsVoiceId, forKey: .ttsVoiceId)
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
