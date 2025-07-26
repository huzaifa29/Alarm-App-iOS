//
//  TabbarView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import SwiftUI

struct TabbarView: View {
    @State private var selectedTab: Tab = .home
    @State private var path = [HomeRoute]()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            PrimaryBackground()
            // Content Views
            Group {
                switch selectedTab {
                case .home:
                    HomeView(path: $path)
                        .padding(.bottom, path.count == 0 ? 90 : 0)
                    
                case .alarm:
                    Text("Alarm View")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if path.count == 0 {
                
                HStack(spacing: 21) {
                    TabBarButton(tab: .home, selectedTab: $selectedTab)
                        .padding(.leading, 20)
                        .padding(.vertical, 11)
                    
                    Image(.icAddTab)
                        .resizable()
                        .frame(width: 34, height: 34)
                        .background (
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(.customABA3F4), Color(.customF5B3FF)]), startPoint: .top, endPoint: .bottom))
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color(.customF6C5FE), Color.white]), startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                .frame(width: 48, height: 48)
                                .shadow(color: Color(.customF5C1FF).opacity(0.7), radius: 15, x: 0, y: 15)
                        )
                        .offset(y: -30)
                    
                    TabBarButton(tab: .alarm, selectedTab: $selectedTab)
                        .padding(.trailing, 20)
                        .padding(.vertical, 11)
                }
                .background(
                    Capsule()
                        .fill(Color(.customFBDFFD))
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                    
                )
            }
        }
    }
    
}

#Preview {
    TabbarView()
}
