//
//  AudioPlayerView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import SwiftUI

struct AudioPlayerView: View {
    @StateObject private var audioPlayer = AudioPlayer()
    
    // Replace with your valid audio URL
    let audioURL = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Audio Player")
                .font(.title)
            
            Button("Play Audio") {
                audioPlayer.playAudio(from: audioURL)
            }

            Button("Stop Audio") {
                audioPlayer.stopAudio()
            }
        }
        .padding()
    }
}
