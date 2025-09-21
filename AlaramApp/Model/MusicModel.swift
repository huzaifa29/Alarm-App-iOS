//
//  MusicModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import SwiftUI

struct MusicModel: Identifiable, Hashable {
    let id = UUID().uuidString
    let name: String
    let background: MusicBackground
    var height = CGFloat.random(in: 86...221)
    
    init(name: String, background: MusicBackground, height: CGFloat = CGFloat.random(in: 86...221)) {
        self.name = name
        self.background = background
        self.height = height
    }
}

struct MusicBackground: Hashable {
    var image: String
    var color: Color
}
