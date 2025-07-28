//
//  UserModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 28/07/2025.
//

import Foundation

struct UserModel: Codable, Hashable {
    let id: String
    let name: String?
    let email: String?
    let language: String?
    let social_type: String?
    let last_login_at: Date?
    let profilePictureURL: String?
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case language
        case social_type
        case last_login_at
        case profilePictureURL = "profile_picture_url"
        case createdAt = "created_at"
    }
}
