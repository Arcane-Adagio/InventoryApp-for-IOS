//
//  Colors.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/9/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }
}

let testColor = Color(hex: "4e2abb")
let royalPurple = Color(hex: "4e2abb")
let royalPurpleMonoA = Color(hex: "9B7EF2")
let royalPurpleMonoB = Color(hex: "6335F0")
let royalPurpleMonoC = Color(hex: "3A2770")
let royalPurpleMonoD = Color(hex: "4E2ABD")
let royalPurpleComplA = Color(hex: "7D52FF")
let royalPurpleComplB = Color(hex: "6335F0")
let royalPurpleCompound = Color(hex: "32158A")
let purple200 = Color(hex: "FFBB86FC")
let purple500 = Color(hex: "FF6200EE")
let purple700 = Color(hex: "FF3700B3")
let darkThemePurple = Color(hex: "FF432272")
let darkThemeTextPurle = Color(hex: "68546c")
let melodicBlue = Color(hex: "84A3F0")
let royalYellow1 = Color(hex: "FFF052")
let royalYellow2 = Color(hex: "6E650D")
let royalYellow3 = Color(hex: "BAAD29")
let red = Color(hex: "de181f")
let offWhite = Color(hex: "bfbfbf")
let tileColor = Color.white
let riyahDarkThemeGrey = Color(hex: "ff5b5b5b")
let darkThemeBackgroundGrey = Color(hex: "2b2b2b")
let darkThemeForegroundGrey = Color(hex: "3a3f43")
let darkThemeComplementaryGrey = Color(hex: "3a3f43")
let darkThemeDefBtnFiller = Color(hex: "787878")
let darkThemeDefBtnAccent = Color(hex: "E6E6E6")
let accentGrey = Color(hex: "C4CDE0")
let teal200 = Color(hex: "FF03DAC5")
let teal700 = Color(hex: "FF018786")
let uiBlue = Color(hex: "ff285386")
let black = Color(hex: "FF000000")
let white = Color(hex: "FFFFFFFF")
let primaryColor = Color(hex: "7e57c2")
let primaryLightColor = Color(hex: "b085f5")
let primaryDarkColor = Color(hex: "4d2c91")
let secondaryColor = Color(hex: "512da8")
let secondaryLightColor = Color(hex: "8559da")
let secondaryDarkColor = Color(hex: "140078")
let primaryTextColor = Color(hex: "ffffff")
let secondaryTextColor = Color(hex: "ffffff")
let onSecondaryColor = Color.white
