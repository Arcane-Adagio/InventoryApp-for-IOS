//
//  FloatingActionButton.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/28/23.
//

import SwiftUI

struct FloatingActionButton: View {
    var action: () -> Void
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button (action: action) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(secondaryLightColor)
                        .clipShape(Circle())
                }
                .tint(secondaryLightColor)
                .shadow(radius: 3)
                .padding(.vertical, 50)
                .padding(.horizontal, 40)
            }
        }
    }
}

struct FloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingActionButton {
            //
        }
    }
}
