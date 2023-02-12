//
//  GenericPopUp.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/11/23.
//

import Foundation
import SwiftUI

struct GenericPopUP: View {
    var PopUpMessage: String
    
    init(msg: String) {
        PopUpMessage = msg
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(25)
                .foregroundColor(purple_200) // TODO: replace with actual color
            // TODO: add lottie file
            Text(PopUpMessage)
                
        }
        .frame(width: 300, height: 100)
    }
}

struct pGroupDeleted_Previews: PreviewProvider {
    static var previews: some View {
        GenericPopUP(msg: "Group no longer exists")
    }
}
