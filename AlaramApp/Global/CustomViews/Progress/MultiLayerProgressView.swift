//
//  MultiLayerProgressView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 17/07/2025.
//

//import SwiftUI
//
//struct MultiLayerProgressView: View {
//    // Progress values for each layer (0.0 to 1.0)
//    @State private var progress1: CGFloat = 0.7
//    @State private var progress2: CGFloat = 0.5
//    @State private var progress3: CGFloat = 0.3
//    
//    var body: some View {
//        ZStack {
//            // Outer arc - Progress
//            Circle()
//                .trim(from: 0, to: progress1 * 0.5) // Half circle (0.5)
//                .stroke(Color(.custom89D1C6), style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//                .frame(width: 250, height: 250)
//            
//            // Outer arc - Remaining
//            Circle()
//                .trim(from: progress1 * 0.5, to: 0.5) // Half circle (0.5)
//                .stroke(Color(.custom89D1C6).opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//                .frame(width: 250, height: 250)
//            
//            // Middle arc - Progress
//            Circle()
//                .trim(from: 0, to: progress2 * 0.5)
//                .stroke(Color(.customFFC5C4), style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//                .frame(width: 200, height: 200)
//
//            // Middle arc - Remaining
//            Circle()
//                .trim(from: progress2 * 0.5, to: 0.5)
//                .stroke(Color(.customFFC5C4).opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//                .frame(width: 200, height: 200)
//            
//            // Inner arc - Progress
//            Circle()
//                .trim(from: 0, to: progress3 * 0.5)
//                .stroke(Color(.customACDCF5), style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//                .frame(width: 150, height: 150)
//            
//            // Inner arc - Remaining
//            Circle()
//                .trim(from: progress3 * 0.5, to: 0.5)
//                .stroke(Color(.customACDCF5).opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//                .frame(width: 150, height: 150)
//            
//            // Optional: Add labels or other UI elements here
////            VStack {
////                Text("Progress")
////                    .font(.title)
////                Text("Outer: \(Int(progress1 * 100))%")
////                Text("Middle: \(Int(progress2 * 100))%")
////                Text("Inner: \(Int(progress3 * 100))%")
////            }
//        }
//        .padding()
//        // For demonstration, animate the progress
//        .onAppear {
//            withAnimation(.easeInOut(duration: 2)) {
//                self.progress1 = 0.9
//                self.progress2 = 0.6
//                self.progress3 = 0.4
//            }
//        }
//    }
//}
//
//#Preview {
//    MultiLayerProgressView()
//}
import SwiftUI

struct MultiLayerProgressView: View {
    // Progress values for each layer (0.0 to 1.0)
    @State private var progress1: CGFloat = 0.7
    @State private var progress2: CGFloat = 0.5
    @State private var progress3: CGFloat = 0.3
    
    // Constants for sizing
    private let lineWidth: CGFloat = 10
    private let ringSpacing: CGFloat = 10
    
    // Calculated sizes based on spacing
    private var outerSize: CGFloat { 120 }
    private var middleSize: CGFloat { outerSize - (lineWidth + ringSpacing) * 2 }
    private var innerSize: CGFloat { middleSize - (lineWidth + ringSpacing) * 2 }
    
    var body: some View {
        ZStack {
            // Outer arc - Progress
            Circle()
                .trim(from: 0, to: progress1 * 0.5)
                .stroke(Color(.custom89D1C6), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: outerSize, height: outerSize)
            
            // Outer arc - Remaining
            Circle()
                .trim(from: progress1 * 0.5, to: 0.5)
                .stroke(Color(.custom89D1C6).opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: outerSize, height: outerSize)
            
            // Middle arc - Progress
            Circle()
                .trim(from: 0, to: progress2 * 0.5)
                .stroke(Color(.customFFC5C4), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: middleSize, height: middleSize)
            
            // Middle arc - Remaining
            Circle()
                .trim(from: progress2 * 0.5, to: 0.5)
                .stroke(Color(.customFFC5C4).opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: middleSize, height: middleSize)
            
            // Inner arc - Progress
            Circle()
                .trim(from: 0, to: progress3 * 0.5)
                .stroke(Color(.customACDCF5), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: innerSize, height: innerSize)
            
            // Inner arc - Remaining
            Circle()
                .trim(from: progress3 * 0.5, to: 0.5)
                .stroke(Color(.customACDCF5).opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: innerSize, height: innerSize)
        }
        .frame(width: 120, height: 157)
        .padding()
        .onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                self.progress1 = 0.9
                self.progress2 = 0.6
                self.progress3 = 0.4
            }
        }
    }
}

#Preview {
    MultiLayerProgressView()
}
