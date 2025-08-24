//
//  MusicModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import Foundation

struct MusicModel: Codable, Hashable {
    
    let id: String?
    let name: String?
    let url: String?
    let thumbnail: String?
    var height = CGFloat.random(in: 86...227)
    
    init(id: String?, name: String?, url: String?, thumbnail: String?) {
        self.id = id
        self.name = name
        self.url = url
        self.thumbnail = thumbnail
        height = CGFloat.random(in: 86...227)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        height = CGFloat.random(in: 86...227)
    }
    
}
