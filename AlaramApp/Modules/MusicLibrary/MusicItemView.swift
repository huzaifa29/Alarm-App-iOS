//
//  MusicItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/07/2025.
//

import SwiftUI

struct MusicItemView: View {
    @State private var imageURL = URL(string: "assa")!
    
    var musicData: MusicModel
    var selectedId: String?
    
    var body: some View {
        ZStack {
            // Play icon
            Image(.icPlay)
                .resizable()
                .frame(width: 52, height: 52)

            // Bottom overlay
            VStack {
                Spacer()
                HStack {
                    Text(musicData.name ?? "")
                        .font(.getFont(.regular, size: 12))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 9)
            }
        }
        .background(
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Color.gray
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                        )
                    
                @unknown default:
                    Color.clear
                }
            }
        )
        .frame(height: musicData.height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            Group {
                if selectedId == musicData.id {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .fill(Color.customE852FF)
                        .padding(.all, -3)
                }
            }
        )
        .onAppear {
            if let thumbnail = musicData.thumbnail, let url = URL(string: thumbnail) {
                imageURL = url
            }
        }
    }

}

#Preview {
    MusicItemView(musicData: .init(id: "", name: "Test", url: "", thumbnail: ""))
}

