//
//  AudioRecordViewModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/08/2025.
//

import AVFoundation
import Combine

class AudioRecordViewModel: NSObject, ObservableObject {
    @Published var amplitudes: [CGFloat] = []
    @Published var isRecording = false
    @Published var isPlaying = false
    @Published var currentPlayTime: TimeInterval = 0
    @Published var currentRecordIndex = 0
    @Published var recordingTime: TimeInterval = 0   // ⏱ current recording duration
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    private var lastRecordedHalfSecond: Double = -1
    private var windowSamples: [CGFloat] = []   // store samples for 0.5s window
    
    private var maxDuration: TimeInterval = 30   // 🎯 30 seconds limit
    
    var recordingURL: URL {
        FileManager.default.temporaryDirectory.appendingPathComponent("recording.m4a")
    }
    
    override init() {
        super.init()
        requestPermission()
    }
    
    func recordingFileExists() -> Bool {
        FileManager.default.fileExists(atPath: recordingURL.path)
    }
    
    // MARK: - Request Microphone Permission
    private func requestPermission() {
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
                print("Microphone access granted")
            } else {
                print("Microphone access denied")
            }
        }
    }
    
    // MARK: - Start Recording
    func startRecording() {
        amplitudes = []
        lastRecordedHalfSecond = -1
        windowSamples = []
        recordingTime = 0
        
        stopPlayback()
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try session.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: recordingURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record(forDuration: maxDuration) // ⏱ Auto-stop at 30s
            isRecording = true
            amplitudes = []
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                self?.updateMeters()
            }
        } catch {
            print("Failed to start recording: \(error)")
        }
    }
    
    // MARK: - Stop Recording
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Update meters for waveform
    private func updateMeters() {
        guard let recorder = audioRecorder, recorder.isRecording else { return }
        recorder.updateMeters()
        
        let avgPower = recorder.averagePower(forChannel: 0)
        let level = pow(10, avgPower / 20)
        let amplitude = max(0.05, CGFloat(level))  // keep a floor so bars are visible
        
        let currentHalfSec = floor(recorder.currentTime * 2) / 2.0
        
        if currentHalfSec != lastRecordedHalfSecond {
            // window ended → reduce samples (take max)
            if !windowSamples.isEmpty {
                let peak = windowSamples.max() ?? 0.1
                let scaled = min(98, max(5, peak * 200)) // scale & clamp (between 5 and 98)
                DispatchQueue.main.async {
                    self.amplitudes.append(scaled)
                    self.currentRecordIndex = self.amplitudes.count - 1
                    if recorder.currentTime > 0 {
                        self.recordingTime = recorder.currentTime
                    }
                }
            }
            
            // reset for new window
            lastRecordedHalfSecond = currentHalfSec
            windowSamples = [amplitude]
        } else {
            // still in same 0.5s → keep adding samples
            windowSamples.append(amplitude)
            DispatchQueue.main.async {
                self.recordingTime = recorder.currentTime
            }
        }
        
        // ⏹ Hard stop if exceeded 30s
        if recorder.currentTime >= maxDuration {
            stopRecording()
        }
    }
    
    // MARK: - Playback
    func startPlayback() {
        stopRecording()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
            audioPlayer?.delegate = self
            audioPlayer?.isMeteringEnabled = true
            audioPlayer?.play()
            isPlaying = true
            currentPlayTime = 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                guard let self = self, let player = self.audioPlayer else { return }
                self.currentPlayTime = player.currentTime
                
                // Auto-stop at 30s
                if self.currentPlayTime >= self.maxDuration || !player.isPlaying {
                    self.stopPlayback()
                }
            }
        } catch {
            print("Failed to play recording: \(error)")
        }
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - AVAudioRecorderDelegate
extension AudioRecordViewModel: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        DispatchQueue.main.async {
            if self.recordingTime > 29 {
                self.recordingTime = self.maxDuration
            }
            self.stopRecording()
        }
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioRecordViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.stopPlayback()
        }
    }
}
