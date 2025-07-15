//
//  AppFonts.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

public extension Font {
    enum AppFonts: String {
        case regular = "Baloo2-Regular"
        case medium = "Baloo2-Medium"
        case semiBold = "Baloo2-SemiBold"
        case bold = "Baloo2-Bold"
        case extraBold = "Baloo2-ExtraBold"
    }
    
    static func getFont(_ type: AppFonts = .regular, size: CGFloat = 15) -> Font {
        return .custom(type.rawValue, size: size)
    }
}
