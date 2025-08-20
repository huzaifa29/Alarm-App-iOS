//
//  HomeRoute.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 22/07/2025.
//

import Foundation

enum HomeRoute: Hashable {
    case selectAlarmType
    case musicLibrary
    case audioRecord
    case textToSpeechAlarm
    case selectSpeechVoice(speechData: SpeechModel)
    case createAlarm(data: AlarmForm)
    case previewAlarm(data: AlarmForm)
    case setAlarm(data: AlarmForm)
    
    static func == (lhs: HomeRoute, rhs: HomeRoute) -> Bool {
        switch (lhs, rhs) {
        case (.selectAlarmType, .selectAlarmType): return true
        case (.musicLibrary, .musicLibrary): return true
        case (.audioRecord, .audioRecord): return true
        case (.textToSpeechAlarm, .textToSpeechAlarm): return true
        case (.selectSpeechVoice, .selectSpeechVoice): return true
        case (.createAlarm, .createAlarm): return true
        case (.previewAlarm, .previewAlarm): return true
        case (.setAlarm, .setAlarm): return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .selectAlarmType:
            return hasher.combine("selectAlarmType")
        case .musicLibrary:
            return hasher.combine("musicLibrary")
        case .audioRecord:
            return hasher.combine("audioRecord")
        case .textToSpeechAlarm:
            return hasher.combine("textToSpeechAlarm")
        case .selectSpeechVoice:
            return hasher.combine("selectSpeechVoice")
        case .createAlarm:
            return hasher.combine("createAlarm")
        case .previewAlarm:
            return hasher.combine("previewAlarm")
        case .setAlarm:
            return hasher.combine("setAlarm")
        }
    }
}
