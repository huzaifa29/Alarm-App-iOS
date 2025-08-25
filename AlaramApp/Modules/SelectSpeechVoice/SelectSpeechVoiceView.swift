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
    @State private var alertData = AlertData()
    @State private var voices: [VoiceModel] = []
    @State private var uploadPath = ""
    @State private var selectedVoiceData: VoiceModel? = nil
    @State private var voiceDict: [String: Data] = [:] // string = voiceId
    @StateObject private var audioPlayer = AudioPlayer()
    
    let api = ElevenLabsAPI()
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var selectedSpeech: SpeechModel
    var supabase: SupabaseManager
    
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
                    guard let selectedVoiceData else { return }
                    if let voiceData = voiceDict[selectedVoiceData.voiceId] {
                        self.uploadVoice(data: voiceData)
                    } else {
                        self.callGetSpeechAudio(voiceId: selectedVoiceData.voiceId) { data in
                            if let audioData = data {
                                self.uploadVoice(data: audioData)
                            }
                        }
                    }
                }
                .opacity(selectedVoiceData == nil ? 0.5 : 1)
                .disabled(selectedVoiceData == nil)
            }
            .padding(.all, 20)
        }
        .loader(isLoading: isLoading)
        .messageAlert($alertData)
        .navigationBarHidden(true)
        .onAppear {
            self.callGetVoices()
        }
        .onDisappear {
            audioPlayer.stop()
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
                    audioPlayer.stop()
                    if let voiceData = voiceDict[data.voiceId] {
                        audioPlayer.playFromData(voiceData)
                    } else {
                        self.callGetSpeechAudio(voiceId: data.voiceId) { audioData in
                            if let audioData {
                                audioPlayer.playFromData(audioData)
                            }
                        }
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

// MARK: - API Calls
extension SelectSpeechVoiceView {
    func callGetVoices() {
        Task {
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
    
    func callGetSpeechAudio(voiceId: String, completion: @escaping (Data?) -> Void) {
        Task {
            isLoading = true
            do {
                let audioData = try await api.fetchSpeechAudio(
                    text: selectedSpeech.description ?? "",
                    voiceId: voiceId
                )
                isLoading = false
                completion(audioData)
            } catch {
                isLoading = false
                alertData.show(message: error.localizedDescription)
            }
        }
    }
    
    func uploadVoice(data: Data) {
        guard let userId = supabase.user?.id.uuidString else { return }
        if uploadPath.isEmpty {
            uploadPath =  userId + "/text-to-speech/" + UUID().uuidString + ".mp3"
        }
        
        Task {
            isLoading = true
            let error = try await supabase.uploadData(bucket: .voiceFiles, data: data, path: uploadPath)
            isLoading = false
            if let error {
                alertData.show(message: error.localizedDescription)
            } else {
                do {
                    let publicURL = try supabase.getPublicURL(bucket: .voiceFiles, path: uploadPath)
                    self.path.append(.createAlarm(data: .init(audioURL: publicURL.absoluteString,
                                                              type: .textToSpeech,
                                                              speechData: self.selectedSpeech)))
                } catch {
                    print("URL Get Error: \(error)")
                    alertData.show(message: error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    SelectSpeechVoiceView(path: .constant([]), selectedSpeech: .init(id: "", userId: "", name: "", description: "", createdAt: .now), supabase: .shared)
}
