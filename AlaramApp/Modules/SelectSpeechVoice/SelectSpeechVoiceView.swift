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
    @State private var voices: [VoiceModel] = []
    @State private var selectedVoiceData: VoiceModel? = nil
    
    let api = ElevenLabsAPI()
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var selectedSpeech: SpeechModel
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Choose a voice for speech")
            
            VStack(spacing: 20) {
                SecondaryTextField(placeholder: "Select Language", text: $language, fieldType: .dropdown)
                
                List {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(voices.indices, id: \.self) { index in
                            let voiceData = voices[index]
                            getVoiceListItem(data: voiceData)
                                .onTapGesture {
                                    self.selectedVoiceData = voiceData
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                PrimaryButton(text: "Use This Voice") {
                    self.path.append(.createAlarm(data: .init(type: .textToSpeech, speechData: self.selectedSpeech, voiceData: self.selectedVoiceData)))
                }
                .opacity(self.selectedVoiceData == nil ? 0.5 : 1)
                .disabled(self.selectedVoiceData == nil)
            }
            .padding(.all, 20)
        }
        .loader(isLoading: isLoading)
        .navigationBarHidden(true)
        .task {
            isLoading = true
            do {
                voices = try await api.fetchVoices()
                isLoading = false
            } catch {
                print("Error loading voices: \(error)")
                isLoading = false
            }
        }
    }
}

// MARK: - UI Methods
extension SelectSpeechVoiceView {
    private func getVoiceListItem(data: VoiceModel) -> some View {
        HStack(spacing: 10) {
            Image(.icAvatar)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(data.name + String(format: "(%@)", data.gender?.capitalized ?? ""))
                .font(.getFont(.bold, size: 16))
                .foregroundStyle(.custom433261)
            
            Spacer()
            
            Image(.speechPlay)
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    Task {
                        self.isLoading = true
                        await api.speak(text: selectedSpeech.description ?? "", voiceId: data.voiceId)
                        self.isLoading = false
                    }
                }
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
    SelectSpeechVoiceView(path: .constant([]), selectedSpeech: .init(id: "", userId: "", name: "", description: "", createdAt: .now))
}
