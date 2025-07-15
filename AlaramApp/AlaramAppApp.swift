//
//  AlaramAppApp.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 14/07/2025.
//

import SwiftUI

@main
struct AlaramAppApp: App {
    @StateObject var viewModel = AuthViewModelImpl()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
