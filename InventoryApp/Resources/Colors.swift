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
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
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

let testColor = Color(hex: "4e2abb")
let royal_purple = Color(hex: "4e2abb")
let royal_purple_monoA = Color(hex: "9B7EF2")
let royal_purple_monoB = Color(hex: "6335F0")
let royal_purple_monoC = Color(hex: "3A2770")
let royal_purple_monoD = Color(hex: "4E2ABD")
let royal_purple_complA = Color(hex: "7D52FF")
let royal_purple_complB = Color(hex: "6335F0")
let royal_purple_compound = Color(hex: "32158A")
let purple_200 = Color(hex: "FFBB86FC")
let purple_500 = Color(hex: "FF6200EE")
let purple_700 = Color(hex: "FF3700B3")
let dark_theme_purple = Color(hex: "FF432272")
let dark_theme_text_purle = Color(hex: "68546c")
let melodic_blue = Color(hex: "84A3F0")
let royal_yellow1 = Color(hex: "FFF052")
let royal_yellow2 = Color(hex: "6E650D")
let royal_yellow3 = Color(hex: "BAAD29")
let red = Color(hex: "de181f")
let off_white = Color(hex: "bfbfbf")
let tile_color = Color.white
let riyah_dark_theme_grey = Color(hex: "ff5b5b5b")
let dark_theme_background_grey = Color(hex: "2b2b2b")
let dark_theme_foreground_grey = Color(hex: "3a3f43")
let dark_theme_complementary_grey = Color(hex: "3a3f43")
let dark_theme_def_btn_filler = Color(hex: "787878")
let dark_theme_def_btn_accent = Color(hex: "E6E6E6")
let accent_grey = Color(hex: "C4CDE0")
let teal_200 = Color(hex: "FF03DAC5")
let teal_700 = Color(hex: "FF018786")
let ui_blue = Color(hex: "ff285386")
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
