//
//  OfflineInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/13/23.
//

import Foundation
import SwiftUI

struct OfflineInventoryView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
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
}

struct OfflineInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineInventoryView()
    }
}
