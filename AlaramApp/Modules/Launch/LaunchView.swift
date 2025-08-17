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
        GeometryReader { geometry in
            Image(.splash)
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(edges: .all)
        .onAppear {
            print("Launch View")
            viewModel.updateState()
        }
    }
}

#Preview {
    LaunchView()
        .environmentObject(AuthViewModelImpl())
}
