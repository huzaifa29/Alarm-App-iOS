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
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var uploadPath = ""
    @State private var showPlayer = false
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var supabase: SupabaseManager
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Customized voice alarm creation")
            
            VStack(spacing: 20) {
                
                PrimaryTextField(icon: "", placeholder: "Name your voice", text: $audioName)
                
                Text("Record your voice")
                    .font(.getFont(.bold, size: 20))
                
                ZStack {
                    Circle()
                        .fill(.pink.opacity(0.2))
                        .frame(width: 150, height: 150)
                    
                    Circle()
                        .fill(.customBBA8F7)
                        .frame(width: 101, height: 101)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 73, height: 73)
                    
                    Image(systemName: "mic.fill")
                        .font(.system(size: 33, weight: .semibold))
                        .foregroundColor(.white)
                    
                }
                .frame(width: 150, height: 150)
                .onTapGesture {
                    showPlayer = true
                    if !viewModel.isRecording {
                        viewModel.startRecording()
                    } else {
                        viewModel.stopRecording()
                    }
                }
                
                Text(viewModel.isRecording ? "Tap to stop recording" : "Tap to start recording")
                    .font(.getFont(.medium, size: 16))
                
                if showPlayer {
                    getAudioPlayerView()
                }
                
                Spacer()
                
                PrimaryButton( text: "Use this Voice") {
                    if audioName.isEmpty {
                        alertMessage = "Enter Voice Name"
                    } else if self.viewModel.recordingTime == 0 || !self.viewModel.recordingFileExists() {
                        self.alertMessage = "Record voice to upload"
                    } else {
                        self.uploadFile()
                    }
                }
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .onChange(of: alertMessage) {
            if !alertMessage.isEmpty {
                showAlert =  true
            } else {
                showAlert = false
            }
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                alertMessage = ""
            }
        }
        .loader(isLoading: self.isLoading)
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
                    UnevenRoundedRectangle(bottomLeadingRadius: 20, bottomTrailingRadius: 30)
                        .fill(.red.opacity(0.1))
                    
                    UnevenRoundedRectangle(bottomLeadingRadius: 20, bottomTrailingRadius: 30)
                        .fill(.purple.opacity(0.3))
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
                        Circle()
                            .fill(.blue)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                            )
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
                            Circle()
                                .fill(.green)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: viewModel.isPlaying ? "pause" : "play")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                )
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
                alertMessage = error.localizedDescription
            } else {
                do {
                    let publicURL = try supabase.getPublicURL(bucket: .voiceFiles, path: uploadPath)
                    self.path.append(.createAlarm(data: .init(audioName: self.audioName, audioURL: publicURL.absoluteString, type: .customized)))
                } catch {
                    print("URL Get Error: \(error)")
                    alertMessage = error.localizedDescription
                }
            }
        }
    }
    
}

// MARK: - Preview
#Preview {
    AudioRecordView(path: .constant([]), supabase: .shared)
}
