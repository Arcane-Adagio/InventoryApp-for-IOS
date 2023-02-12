//
//  ProfileInfoCard.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/11/23.
//

import SwiftUI

struct ProfileInfoCard: View {
    var body: some View {
        ZStack {
            secondaryLightColor
        }
        .frame(height: 250)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(purple200, lineWidth: 3)

        )
        .shadow(radius: 3)
        .padding()
    }
}

struct ProfileInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoCard()
    }
}
