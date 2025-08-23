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
    
}
