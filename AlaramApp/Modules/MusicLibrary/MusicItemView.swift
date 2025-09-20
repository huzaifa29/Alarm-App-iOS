//
//  MusicItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/07/2025.
//

import SwiftUI

struct MusicItemView: View {
    var musicData: MusicModel
    var isSelected: Bool = false
    var isPlaying: Bool = false
    
    private let radius: CGFloat = 10
    
    var body: some View {
        ZStack {
            // Play icon
            HStack {
                Spacer()
                Image((isSelected && isPlaying) ? .icPause : .icPlay)
                    .resizable()
                    .frame(width: 52, height: 52)
                Spacer()
            }
            
            // Text
            VStack {
                Spacer()
                Text(musicData.name)
                    .font(.getFont(.medium, size: 12))
                    .foregroundStyle(.custom2D2D40)
            }
            .padding([.horizontal, .bottom], 8)
        }
        .background(
            // Background Image
            Image(musicData.background.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(
                    Group {
                        if isSelected {
                            Color.white
                        } else {
                            musicData.background.color
                        }
                    }
                )
        )
        .frame(height: musicData.height)
        .clipShape(.rect(cornerRadius: radius))
        .overlay(
            Group {
                if isSelected {
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(lineWidth: 4)
                        .fill(musicData.background.color)
                }
            }
        )
    }
    
}

#Preview {
//    MusicItemView(musicData: .init(name: "Amberlight", background: .init(image: "music-bg-1", color: .green)))
}

