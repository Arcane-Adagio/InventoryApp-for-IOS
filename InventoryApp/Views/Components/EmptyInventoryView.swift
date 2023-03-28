//
//  EmptyInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/28/23.
//

import SwiftUI

struct EmptyInventoryView: View {
    var text: String
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                primaryDarkColor.opacity(0.3)
                    .frame(height: 100)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                Text(text)
                    .shadow(radius: 3)
            }
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
    }
}

struct EmptyInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyInventoryView(text: "No inventories to show")
    }
}
