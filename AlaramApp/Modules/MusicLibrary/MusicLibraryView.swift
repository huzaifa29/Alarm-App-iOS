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
    
    @State var isSelected = false
    @State private var isLoading = false
    @State private var arrayMusic: [MusicModel] = []
    
    let supabase: SupabaseManager
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TopBarView<HomeRoute>(path: $path, title: "Music Library")
                
                ScrollView {
                    WaterfallGrid(arrayMusic, id: \.self) { musicData in
                        MusicItemView(musicData: musicData)
                    }
                    .gridStyle(columns: 2,
                               spacing: 20)
                    .padding()
                }
                .padding(.top, 22)
                
                PrimaryButton(text: isSelected ? "Next" : "Select Music") {
                    if isSelected {
                        self.path.append(.createAlarm)
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
        .navigationBarHidden(true)
    }
}

// MARK: - Methods
extension MusicLibraryView {
    func callGetMusic() {
        Task {
            isLoading = true
            self.arrayMusic = await supabase.fetchTable(table: "music", as: MusicModel.self) ?? []
            print("✅ Fetched \(arrayMusic.count) songs:")
            for music in arrayMusic {
                print("🎵 \(music.name) by \(music.thumbnail)")
            }
            self.isLoading = false
        }
    }
}

#Preview {
    MusicLibraryView(path: .constant([]), supabase: .shared)
}
