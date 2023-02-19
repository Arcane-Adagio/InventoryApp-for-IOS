//
//  BackgroundView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/9/23.
//

import SwiftUI

struct BackgroundView: View {
    let lightPurple = Color(hex: "7550bc")
    let darkPurple = Color(hex: "1c067d")
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [lightPurple, darkPurple]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
