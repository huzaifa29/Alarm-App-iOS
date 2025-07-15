//
//  LaunchView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 15/07/2025.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var viewModel: AuthViewModelImpl
    
    var body: some View {
        Text("Alaram App")
            .frame(alignment: .center)
            .onAppear {
                print("Launch View")
                viewModel.updateState()
            }
    }
}

#Preview {
    LaunchView()
}
