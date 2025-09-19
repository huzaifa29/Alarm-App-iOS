//
//  ElevenLabsAPI.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 23/08/2025.
//

import Foundation
import AVFoundation

class ElevenLabsAPI {
    private let apiKey = "sk_3210498ba700a56c2a59bcd19c6858cf0b42aab0266f9996"
    private let baseURL = "https://api.elevenlabs.io/v1/"
    
    func fetchVoices() async throws -> [VoiceModel] {
        guard let url = URL(string: baseURL + "voices") else {
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
    
    func fetchSpeechAudio(text: String, voiceId: String) async throws -> Data {
        guard let url = URL(string: baseURL + "text-to-speech/\(voiceId)") else {
            throw URLError(.badURL)
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
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NSError(
                domain: "TTSService",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: "TTS request failed with status code \(httpResponse.statusCode)"]
            )
        }
        
        return data
    }
}
