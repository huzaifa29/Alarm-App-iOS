//
//  SpeechModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 20/08/2025.
//

import Foundation

struct SpeechModel: Codable, Hashable {
    
    let id: String = UUID().uuidString
    let userId: String
    let name: String?
    let description: String?
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case description
        case createdAt = "created_at"
    }
}
