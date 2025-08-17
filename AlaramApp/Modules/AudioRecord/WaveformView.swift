//
//  WaveformView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/08/2025.
//

import SwiftUI

struct WaveformView: View {
    var amplitudes: [CGFloat]
    var highlightUntil: Int? = nil
    var recordingIndex: Int? = nil
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(amplitudes.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(i <= (highlightUntil ?? -1) ? Color.white : Color.black)
                            .frame(width: 5, height: amplitudes[i])
                            .id(i)
                    }
                }
            }
            .frame(height: 100)
            .onChange(of: highlightUntil) {
                if let idx = highlightUntil {
                    withAnimation(.linear(duration: 0.05)) {
                        proxy.scrollTo(idx, anchor: .center)
                    }
                }
            }
            .onChange(of: recordingIndex) {
                if let idx = recordingIndex {
                    withAnimation(.linear(duration: 0.05)) {
                        proxy.scrollTo(idx, anchor: .trailing)
                    }
                }
            }
        }
    }
}
