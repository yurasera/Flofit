//
//  extension+Color.swift
//  LiMaChallenge3
//
//  Created by Juan Fausta Pringadi on 05/06/26.
//

import Foundation
import SwiftUI

extension Color {
    //Background Color
    static let DarkModeBackgroundColorScreen = Color(hex: "#0D0D0D")
    static let DarkModeBackgroundColorSurface = Color(hex: "#ECECF9")
    static let DarkModeBackgroundColorClickable = Color(hex: "#181819")
    static let DarkModeBackgroundColorGray = Color(hex: "#232325")
    static let DarkModeBackgroundColorDark = Color(hex: "#121212")
    static let DarkModeBackgroundColorClickableSurface = Color(hex: "#2A1617")
    
    // Text Color
    static let DarkModeTextColorPrimary = Color(hex: "#F2F2F7")
    static let DarkModeTextColorSecondary = Color(hex: "#8E8E93")
    static let DarkModeTextColorPlaceholder = Color(hex: "#5C5C5E")
    
    // Brand Color
    static let DarkModeBrandColorPrimary = Color(hex: "#B3272B")
    
    // Status Color
    static let DarkModeStatusColorHigh = Color(hex: "#24BC4B")
    static let DarkModeStatusColorHighGradient = Color(hex: "#1C6430")
    static let DarkModeStatusColorBalance = Color(hex: "#C8AE24")
    static let DarkModeStatusColorBalanceGradient = Color(hex: "#62581B")
    static let DarkModeStatusColorLow = Color(hex: "#BF3D25")
    static let DarkModeStatusColorLowGradient = Color(hex: "#612B1C")
    
    // Metric Color
    static let DarkModeMetricColorHRV = Color(hex: "#5AC8FA")
    static let DarkModeMetricColorRHR = Color(hex: "#FF6482")
    static let DarkModeMetricColorSleep = Color(hex: "#A2AAFF")
    
    // Chart Color
    static let DarkModeChartColorLine = Color(hex: "#2751B3")
    
    // Effort Color
    static let DarkModeFeelingColorEmpty = Color(hex: "#94A3B8")
    static let DarkModeFeelingColorEmptyLabel = Color(hex: "#1F2022")
    static let DarkModeFeelingColorPrime = Color(hex: "#00E5FF")
    static let DarkModeFeelingColorPrimeLabel = Color(hex: "#162D30")
    static let DarkModeFeelingColorEnergized = Color(hex: "#1DA1F2")
    static let DarkModeFeelingColorEnergizedLabel = Color(hex: "#19262E")
    static let DarkModeFeelingColorSteady = Color(hex: "#7A8BFF")
    static let DarkModeFeelingColorSteadyLabel = Color(hex: "#232430")
    static let DarkModeFeelingColorExhausted = Color(hex: "#C882FF")
    static let DarkModeFeelingColorExhaustedLabel = Color(hex: "#2A232F")
    static let DarkModeFeelingColorFatigued = Color(hex: "#E86F97")
    static let DarkModeFeelingColorFatiguedLabel = Color(hex: "#2E2226")
    
    // UI
    static let DarkModeUIShadow = Color(hex: "#0B0B0B") //opacity 40% //sudah diubah jadi hex biasa, jadi ga perlu atur opacity lagi
    
    // Condition color
    static let DarkModeConditionSelected = Color(hex: "#F9F9F9")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
