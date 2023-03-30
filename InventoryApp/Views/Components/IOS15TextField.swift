//
//  IOS15TextField.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/30/23.
//

import SwiftUI

struct IOS15TextField: View {
    var editMode: Bool
    @Binding var text: String

    var body: some View {
        ZStack {
            TextEditor(text: $text)
                .disabled(!editMode)
                .font(.system(size: 14, weight: .light, design: .rounded))
                .opacity(!editMode ? 0 : 0.1)
                .lineLimit(nil)
                .padding(.horizontal)
            VStack {
                HStack {
                    Text(text)
                        .font(.system(size: 14, weight: .light, design: .rounded))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.leading, 5)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 7)
        }
    }
}

struct IOS15TextField_Previews: PreviewProvider {
    static var previews: some View {
        IOS15TextField(editMode: true, text: .constant("Yeessh"))
    }
}
