//
//  SelectSpeechVoiceView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 20/08/2025.
//

import SwiftUI

struct SelectSpeechVoiceView: View {
    @State private var language: String = ""
    @State private var arraySpeech = [SpeechModel]()
    @State private var isLoading = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var selectedSpeech: SpeechModel
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Text to speech alarm creation")
            
            VStack(spacing: 20) {
                SecondaryTextField(placeholder: "Select Language", text: $language, fieldType: .dropdown)
                
                List {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(0...3, id: \.self) { index in
                            getListItem(name: "Emli")
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                PrimaryButton(text: "Use This Voice") {
                    print("use this voice")
                }
            }
            .padding(.all, 20)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - UI Methods
extension SelectSpeechVoiceView {
    private func getListItem(name: String) -> some View {
        HStack(spacing: 10) {
            Image(.icAvatar)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(name)
                .font(.getFont(.bold, size: 16))
                .foregroundStyle(.custom433261)
            
            Spacer()
            
            Image(.speechPlay)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 17)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.customFFF6FB)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(colors: [.white.opacity(0), .white, .white.opacity(0)],
                                           startPoint: .top,
                                           endPoint: .bottom),
                            lineWidth: 1.5
                        )
                )
        )
    }
}

#Preview {
    SelectSpeechVoiceView(path: .constant([]), selectedSpeech: .init(userId: "", name: "", description: "", createdAt: .now))
}
