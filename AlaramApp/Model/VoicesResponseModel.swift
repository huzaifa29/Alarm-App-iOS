//
//  Voice.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/08/2025.
//

import Foundation

struct VoicesResponseModel: Codable {
    let voices: [VoiceModel]
}

struct VoiceModel: Codable {
    let voiceId: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case voiceId = "voice_id"
        case name
    }
}
