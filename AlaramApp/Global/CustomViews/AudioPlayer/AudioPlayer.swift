//
//  AudioPlayer.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import AVFoundation

class AudioPlayer: NSObject, ObservableObject {
    private var player: AVPlayer?
    
    @Published var isPlaying = false
    var url: URL?
    
    func playAudio(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        self.url = url
        
        observePlayerStatus()
        player?.play()
    }
    
    func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    private func observePlayerStatus() {
        // Observe timeControlStatus changes
        player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.new, .initial], context: nil)
    }
    
    // Observe callback
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus",
           let player = object as? AVPlayer {
            DispatchQueue.main.async {
                self.isPlaying = player.timeControlStatus == .playing
            }
        }
    }
    
    deinit {
        player?.removeObserver(self, forKeyPath: "timeControlStatus")
    }
}
