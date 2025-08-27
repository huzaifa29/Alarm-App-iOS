//
//  AudioRecordView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/08/2025.
//

import SwiftUI

struct AudioRecordView: View {
    @StateObject private var viewModel = AudioRecordViewModel()
    @State private var audioName: String = ""
    @State private var isLoading = false
    @State private var alertData = AlertData()
    @State private var uploadPath = ""
    @State private var showPlayer = false
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var supabase: SupabaseManager
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Customized voice alarm creation")
            
            VStack(spacing: 20) {
                
                PrimaryTextField(placeholder: "Name your voice", text: $audioName, showNewDesign: true)
                
                Text("Record your voice")
                    .font(.getFont(.bold, size: 20))
                    .foregroundStyle(.custom2D2D40)
                
                Button {
                    showPlayer = true
                    if !viewModel.isRecording {
                        viewModel.startRecording()
                    } else {
                        viewModel.stopRecording()
                    }
                } label: {
                    Image(.micIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 151, height: 151)
                        .frame(width: 150, height: 150)
                }
                
                Text(viewModel.isRecording ? "Tap to stop recording" : "Tap to start recording")
                    .font(.getFont(.medium, size: 16))
                    .foregroundStyle(.black)
                
                if showPlayer {
                    getAudioPlayerView()
                }
                
                Spacer()
                
                SecondaryButton( text: "Use this Voice") {
                    if audioName.isEmpty {
                        alertData.show(message: "Enter Voice Name")
                    } else if self.viewModel.recordingTime == 0 || !self.viewModel.recordingFileExists() {
                        alertData.show(message: "Record voice to upload")
                    } else {
                        self.uploadFile()
                    }
                }
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .loader(isLoading: self.isLoading)
        .messageAlert($alertData)
        .navigationBarHidden(true)
    }
}

// MARK: - UI Methods
extension AudioRecordView {
    func getAudioPlayerView() -> some View {
        VStack(spacing: 20 ) {
            VStack(spacing: 10) {
                HStack {
                    Text("0 sec")
                        .font(.getFont(.medium, size: 12))
                    Spacer()
                    if !viewModel.isRecording {
                        Text("\(viewModel.recordingTime.getSeconds() / 2) sec")
                            .font(.getFont(.medium, size: 12))
                        Spacer()
                    }
                    Text("\(viewModel.recordingTime.getSeconds()) sec")
                        .font(.getFont(.medium, size: 12))
                }
                
                ZStack {
                    UnevenRoundedRectangle(bottomLeadingRadius: 24, bottomTrailingRadius: 24)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "#ECBBE8").opacity(0.6),
                                    Color(hex: "#F3F3DF"),
                                    Color(hex: "#C9EACF").opacity(0.6)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    UnevenRoundedRectangle(bottomLeadingRadius: 24, bottomTrailingRadius: 24)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "#ECBBE8"),
                                    Color(hex: "#F3F3DF"),
                                    Color(hex: "#C9EACF")
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .padding(.horizontal, 20)
                    
                    WaveformView(
                        amplitudes: viewModel.amplitudes,
                        highlightUntil: viewModel.isPlaying ? Int(viewModel.currentPlayTime * 2) : nil,
                        recordingIndex: viewModel.isRecording ? viewModel.currentRecordIndex : nil
                    )
                    .padding(.horizontal, 40)
                }
                .frame(height: 100)
            }
            
            HStack(spacing: 50) {
                Button {
                    viewModel.startRecording()
                } label: {
                    VStack(spacing: 10) {
                        Image(.restartIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text("Restart recording")
                            .font(.getFont(.medium, size: 12))
                            .foregroundStyle(.black)
                    }
                    
                }
                
                if !viewModel.isRecording {
                    Button {
                        if !viewModel.isPlaying {
                            viewModel.startPlayback()
                        } else {
                            viewModel.stopPlayback()
                        }
                    } label: {
                        VStack(spacing: 10) {
                            Image(.playRecordingIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .shadow(color: Color(hex: "#6CE484").opacity(0.35), radius: 15.3, x: 0, y: 15)
                            
                            Text(viewModel.isPlaying ? "Stop Playing" : "Play recording")
                                .font(.getFont(.medium, size: 12))
                                .foregroundStyle(.black)
                        }
                        
                    }
                }
            }
        }
    }
}

// MARK: - Methods
extension AudioRecordView {
    private func uploadFile() {
        Task {
            guard let userId = supabase.user?.id.uuidString else { return }
            if uploadPath.isEmpty {
                uploadPath =  userId + "/" + UUID().uuidString + ".m4a"
            }
            
            self.isLoading = true
            let error = try await supabase.uploadFile(bucket: .voiceFiles, fileURL: viewModel.recordingURL, path: uploadPath, contentType: "audio/m4a")
            self.isLoading = false
            if let error = error {
                alertData.show(message: error.localizedDescription)
            } else {
                do {
                    let publicURL = try supabase.getPublicURL(bucket: .voiceFiles, path: uploadPath)
                    self.path.append(.createAlarm(data: .init(audioName: self.audioName, audioURL: publicURL.absoluteString, type: .customized)))
                } catch {
                    print("URL Get Error: \(error)")
                    alertData.show(message: error.localizedDescription)
                }
            }
        }
    }
    
}

// MARK: - Preview
#Preview {
    AudioRecordView(path: .constant([]), supabase: .shared)
}
