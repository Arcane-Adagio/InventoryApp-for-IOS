//
//  GenericPopUp.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/11/23.
//

import Foundation
import SwiftUI

struct GenericPopUP: View {
    var popUpMessage: String

    init(msg: String) {
        popUpMessage = msg
    }

    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(25)
                .foregroundColor(purple200) // TODO: replace with actual color
            // TODO: add lottie file
            Text(popUpMessage)
        }
        .frame(width: 300, height: 100)
    }
}

struct GenericPopUp_Previews: PreviewProvider {
    static var previews: some View {
        GenericPopUP(msg: "Group no longer exists")
    }
}
