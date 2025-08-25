//
//  AlertData.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 25/08/2025.
//

import Foundation

struct AlertData {
    var title: String = ""
    var message: String = ""

    var isPresented: Bool {
        !title.isEmpty || !message.isEmpty
    }

    mutating func show(title: String = "", message: String) {
        self.title = title
        self.message = message
    }

    mutating func dismiss() {
        title = ""
        message = ""
    }
}
