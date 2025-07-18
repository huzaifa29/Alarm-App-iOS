//
//  TabBarButton.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

import SwiftUI

struct TabBarButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(selectedTab == tab ? tab.selectedIcon : tab.icon)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text(tab.title)
                    .font(.getFont(.bold, size: 12))
                    .foregroundStyle(selectedTab == tab ? .customFF7FAA : .custom2D2D40)
            }
            .frame(width: 50, height: 48)
        }
    }
}

#Preview {
    TabBarButton(tab: .home, selectedTab: .constant(.home))
}
