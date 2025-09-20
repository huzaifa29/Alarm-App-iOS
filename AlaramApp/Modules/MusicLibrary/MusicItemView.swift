//
//  MusicItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/07/2025.
//

import SwiftUI

struct MusicItemView: View {
    var musicData: MusicModel
    var selectedMusic: MusicModel?
    
    var body: some View {
        ZStack {
            // Play icon
            Image((self.selectedMusic?.id == musicData.id  && self.selectedMusic?.isPlaying ?? false) ? .icPause : .icPlay)
                .resizable()
                .frame(width: 52, height: 52)
            
            // Bottom overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(musicData.name)
                        .font(.getFont(.medium, size: 12))
                        .foregroundStyle(.custom2D2D40)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 9)
            }
        }
        .background(
            // Background Image
            Image(musicData.background.image)
                .resizable()
                .scaledToFill()
                .background(
                    Group {
                        if selectedMusic?.id == musicData.id {
                            Color.white
                        } else {
                            musicData.background.color
                        }
                    }
                )
        )
        .frame(height: musicData.height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            Group {
                if selectedMusic?.id == musicData.id {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4)
                        .fill(musicData.background.color)
                }
            }
        )
    }
    
}

#Preview {
    MusicItemView(musicData: .init(name: "Amberlight", background: .init(image: "music-bg-1", color: .green)))
}

