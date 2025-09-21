//
//  MusicLibraryView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 22/07/2025.
//

import SwiftUI
import WaterfallGrid

struct MusicLibraryView: View {
    @Binding var path: [HomeRoute]
    
    @StateObject private var audioPlayer = AudioPlayer()
    
    @State private var isAppear = false
    @State private var arrayMusic: [MusicModel] = []
    @State private var selectedMusic: MusicModel? = nil
    
    let supabase: SupabaseManager
    
    var body: some View {
        ZStack {
            PrimaryBackground()
            
            VStack(spacing: 0) {
                TopBarView<HomeRoute>(path: $path, title: "Music Library")
                
                ScrollView {
                    WaterfallGrid(arrayMusic, id: \.self) { musicData in
                        MusicItemView(musicData: musicData,
                                      isSelected: selectedMusic?.id == musicData.id,
                                      isPlaying: selectedMusic?.isPlaying ?? false)
                            .contentShape(.rect)
                            .onTapGesture {
                                if let audioURL = Bundle.main.url(forResource: musicData.name, withExtension: "wav") {
                                    self.selectedMusic = musicData
                                    if audioPlayer.isPlaying && audioPlayer.url == audioURL {
                                        audioPlayer.stop()
                                        self.selectedMusic?.isPlaying = audioPlayer.isPlaying
                                    } else {
                                        audioPlayer.stop()
                                        audioPlayer.playFromURL(audioURL)
                                        self.selectedMusic?.isPlaying = audioPlayer.isPlaying
                                    }
                                } else {
                                    self.selectedMusic?.isPlaying = false
                                }
                            }
                    }
                    .gridStyle(columns: 2,
                               spacing: 20)
                    .padding()
                }
                .padding(.top, 22)
                
                PrimaryButton(text: "Next") {
                    self.selectedMusic?.isPlaying = false
                    self.path.append(.createAlarm(data: .init(audioName: selectedMusic?.name, musicData: selectedMusic, type: .basic)))
                }
                .opacity(self.selectedMusic == nil ? 0.5 : 1)
                .disabled(self.selectedMusic == nil)
                .padding(.all, 20)
            }
        }
        .onAppear {
            if !isAppear {
                self.loadMusic()
                isAppear = true
            }
        }
        .onDisappear {
            audioPlayer.stop()
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Methods
extension MusicLibraryView {
    func loadMusic() {
        let arrayMusicBackground: [MusicBackground] = [
            .init(image: "music-bg-1", color: .hexB4E086),
            .init(image: "music-bg-2", color: .hex8F98FF),
            .init(image: "music-bg-3", color: .hexF2D8FF),
            .init(image: "music-bg-4", color: .hexFFC28A),
            .init(image: "music-bg-5", color: .hex7AB6FF),
            .init(image: "music-bg-6", color: .hexFF8EB5),
            .init(image: "music-bg-7", color: .hexB4E086),
        ]

        let musicNames = ["Amberlight",
                          "Autumn Scene",
                          "Harmony",
                          "Healing",
                          "lullaby",
                          "moonlight",
                          "Starlit Beach",
                          "Sunset",
                          "The Open Sky"]

        // Shuffle the backgrounds
        var shuffledBackgrounds = arrayMusicBackground.shuffled()

        // If there are more music items than backgrounds, repeat the shuffled list
        while shuffledBackgrounds.count < musicNames.count {
            shuffledBackgrounds.append(contentsOf: arrayMusicBackground.shuffled())
        }

        // Now assign 1-to-1 without repetition until all backgrounds are used
        self.arrayMusic = zip(musicNames, shuffledBackgrounds).map { name, bg in
            MusicModel(name: name, background: bg)
        }
    }
}

#Preview {
    MusicLibraryView(path: .constant([]), supabase: .shared)
}
