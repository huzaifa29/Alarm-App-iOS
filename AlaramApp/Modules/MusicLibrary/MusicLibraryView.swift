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
    
    @State private var isLoading = false
    @State private var arrayMusic: [MusicModel] = []
    @State private var selectedMusic: MusicModel? = nil
    @State private var selectedId: String? = nil
    
    let supabase: SupabaseManager
    
    var body: some View {
        ZStack {
            PrimaryBackground()
            
            VStack(spacing: 0) {
                TopBarView<HomeRoute>(path: $path, title: "Music Library")
                
                ScrollView {
                    WaterfallGrid(arrayMusic, id: \.self) { musicData in
                        MusicItemView(musicData: musicData, selectedId: selectedId)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if let url = musicData.url, let audioURL = URL(string: url) {
                                    self.selectedMusic = musicData
                                    if audioPlayer.isPlaying && audioPlayer.url == audioURL {
                                        audioPlayer.stopAudio()
                                    } else {
                                        audioPlayer.stopAudio()
                                        audioPlayer.playAudio(from: audioURL)
                                    }
                                }
                            }
                    }
                    .gridStyle(columns: 2,
                               spacing: 20)
                    .padding()
                }
                .padding(.top, 22)
                
                PrimaryButton(text: selectedId != nil ? "Next" : "Select Music") {
                    if selectedId != nil {
                        self.path.append(.createAlarm(data: .init(musicData: selectedMusic)))
                    } else {
                        selectedId = selectedMusic?.id
                    }
                    
                }
                .padding(.all, 20)
            }
            
            if isLoading {
                LoaderView()
            }
        }
        .onAppear {
            self.callGetMusic()
        }
        .onDisappear {
            audioPlayer.stopAudio()
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Methods
extension MusicLibraryView {
    func callGetMusic() {
        Task {
            isLoading = true
            self.arrayMusic = await supabase.fetchTable(table: "music", as: MusicModel.self) ?? []
            self.isLoading = false
        }
    }
}

#Preview {
    MusicLibraryView(path: .constant([]), supabase: .shared)
}
