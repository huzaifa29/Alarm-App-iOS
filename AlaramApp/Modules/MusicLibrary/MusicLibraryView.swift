//
//  MusicLibraryView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 22/07/2025.
//

import SwiftUI

struct MusicLibraryView: View {
    @Binding var path: [HomeRoute]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var isSelected = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Music Library")
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<10, id: \.self) { index in
                        Rectangle()
                            .fill(Color.custom2D2D40)
                            .frame(height: 100)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                isSelected = true
                            }
                            .background(
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .fill(isSelected ? .pink : .clear)
                            )
                    }
                }
            }
            .padding(.all, 20)
            
            PrimaryButton(text: isSelected ? "Next" : "Select Music") {
                
            }
            .padding([.horizontal, .trailing], 20)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MusicLibraryView(path: .constant([]))
}
