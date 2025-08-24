//
//  AudioPlayer.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import AVFoundation

class AudioPlayer: NSObject, ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var avPlayer: AVPlayer?
    
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    
    private var timer: Timer?
    var url: URL?
    
    // MARK: - Play from URL (local OR remote)
    func playFromURL(_ url: URL) {
        self.url = url
        stop() // reset before playing
        
        if url.isFileURL {
            // Local file → AVAudioPlayer
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                
                isPlaying = true
                duration = audioPlayer?.duration ?? 0
                startTimer()
            } catch {
                print("❌ AVAudioPlayer error:", error.localizedDescription)
            }
        } else {
            // Remote file → AVPlayer
            avPlayer = AVPlayer(url: url)
            avPlayer?.play()
            
            isPlaying = true
            observeAVPlayer()
        }
    }
    
    // MARK: - Play from Data (only AVAudioPlayer supports this)
    func playFromData(_ data: Data) {
        stop()
        
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            isPlaying = true
            duration = audioPlayer?.duration ?? 0
            startTimer()
        } catch {
            print("❌ AVAudioPlayer error:", error.localizedDescription)
        }
    }
    
    // MARK: - Pause
    func pause() {
        audioPlayer?.pause()
        avPlayer?.pause()
        isPlaying = false
    }
    
    // MARK: - Resume
    func resume() {
        audioPlayer?.play()
        avPlayer?.play()
        isPlaying = true
    }
    
    // MARK: - Stop
    func stop() {
        audioPlayer?.stop()
        avPlayer?.pause()
        audioPlayer = nil
        avPlayer = nil
        isPlaying = false
        currentTime = 0
        duration = 0
        stopTimer()
    }
    
    // MARK: - Helpers
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let player = self.audioPlayer {
                self.currentTime = player.currentTime
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func observeAVPlayer() {
        guard let player = avPlayer, let asset = player.currentItem?.asset else { return }
        
        // Load duration asynchronously using async/await API
        Task {
            let duration = try await asset.load(.duration)
            Task { @MainActor in
                self.duration = duration.seconds
            }
        }
        
        // Observe current time
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600),
                                       queue: .main) { time in
            self.currentTime = time.seconds
        }
        
        // Observe end of playback
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem,
                                               queue: .main) { _ in
            self.stop()
        }
    }
    
}

// MARK: - AVAudioPlayer Delegate
extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stop()
    }
}
