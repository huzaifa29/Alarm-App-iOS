//
//  MusicItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 24/07/2025.
//

import SwiftUI

struct MusicItemView: View {
    let imageName: String
    let title: String
    let isSelected: Bool = false
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
//            .frame(height: CGFloat.random(in: 86...227))
            .frame(height: 200)
            .cornerRadius(10)
            .clipped()
            .overlay(
                ZStack {
                    Image(.icPlay)
                        .resizable()
                        .frame(width: 52, height: 52)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Text(title)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.bottom, 9)
                    }
                    
                }
                
            )
            .overlay(
                Group {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.5)
                            .fill(.customE852FF)
                            .padding(.all, -3)
                    }
                }
            )
    }
}


#Preview {
    MusicItemView(imageName: "song_image", title: "Test")
}

