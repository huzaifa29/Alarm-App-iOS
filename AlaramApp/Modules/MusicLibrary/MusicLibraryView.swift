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
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Music Library")
            
            ScrollView {
                WaterfallGrid(0..<30, id: \.self) { _ in
                    MusicItemView(imageName: "song_image", title: "test")
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
        .navigationBarHidden(true)
    }
}

#Preview {
    MusicLibraryView(path: .constant([]))
}
