//
//  ElevenLabsAPI.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/08/2025.
//

import Foundation
import AVFoundation

class ElevenLabsAPI {
    private let apiKey = "sk_a4fc19f4cab076198527c286b678be5289763ee2edf9a9cb"
    private var player: AVAudioPlayer?
    
    func fetchVoices() async throws -> [VoiceModel] {
        guard let url = URL(string: "https://api.elevenlabs.io/v1/voices") else {
            return []
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            print("Failed to fetch voices: \(response)")
            return []
        }
        
        let decoded = try JSONDecoder().decode(VoicesResponseModel.self, from: data)
        return decoded.voices
    }
    
    func speak(text: String, voiceId: String) async {
        stopAudio()
        guard let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(voiceId)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")

        // Request body
        let body: [String: Any] = [
            "text": text,
            "voice_settings": [
                "stability": 0.5,
                "similarity_boost": 0.75
            ]
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("TTS request failed: \(response)")
                return
            }

            try playAudio(data: data)
        } catch {
            print("Error fetching TTS: \(error)")
        }
    }

    private func playAudio(data: Data) throws {
        player = try AVAudioPlayer(data: data)
        player?.prepareToPlay()
        player?.play()
    }
    
    func stopAudio() {
        player?.stop()
        player = nil
    }
}
