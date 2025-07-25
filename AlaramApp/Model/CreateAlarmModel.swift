//
//  CreateAlarmModel.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/07/2025.
//

import Foundation

struct CreateAlarmModel {
    var musicData: MusicModel?
    var hour: Int = 6
    var minute: Int = 30
    var note: String = ""
    var name: String = ""
    var repeatDays: [Days] = []
}

enum Days: String, CaseIterable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}
