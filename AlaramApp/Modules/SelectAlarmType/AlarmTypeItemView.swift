//
//  AlarmTypeItemView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 22/07/2025.
//

import SwiftUI

struct AlarmTypeItemView: View {
    var dataModel: DataModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(spacing: 10) {
                Image(dataModel.image)
                    .resizable()
                    .frame(width: 18, height: 18)
                
                Text(dataModel.title)
                    .foregroundStyle(.custom2D2D40)
                    .font(.getFont(.bold, size: 16))
                
                Spacer()
            }
            
            Text(dataModel.desc)
                .foregroundStyle(.custom433261)
                .font(.getFont(.medium, size: 14))
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(dataModel.isSelected ? .custom9287FF.opacity(0.20) : Color.white)
                .overlay(
                    Group {
                        if dataModel.isSelected {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.customA88CF2, lineWidth: 1)
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    LinearGradient(
                                        colors: [.white.opacity(0), .white, .white.opacity(0)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 1.5
                                )
                        }
                    }
                )
                .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 0)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

extension AlarmTypeItemView {
    struct DataModel {
        var image: String
        var title: String
        var desc: String
        var isSelected: Bool
    }
}

#Preview {
    AlarmTypeItemView(dataModel: .init(image: "ic_music",
                                       title: "Title",
                                       desc: "Desc",
                                       isSelected: true))
}
