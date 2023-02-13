//
//  GenericButton.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/11/23.
//

import SwiftUI

struct GenericButton: View {
    var txt: String
    var action: () -> Void

    var body: some View {
        Button(txt) {
            action()
        }
        .buttonStyle(.borderedProminent)
        .tint(secondaryLightColor)
        .shadow(radius: 3)
    }
}

struct GenericButtonOutline: View {
    var txt: String
    var action: () -> Void

    var body: some View {
        Button(txt) {
            action()
        }
        .buttonStyle(.plain)
        .frame(width: 72, height: 31)
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke()
        )
        .shadow(radius: 3)
    }
}

struct ConditionalButton: View {
    var txt: String
    @Binding var isActive: Bool
    var action: () -> Void
    let enabledRadius: CGFloat = 7
    let disabledRadius: CGFloat = 10

    var body: some View {
        Button {
            action()
        } label: {
            Text(txt)
                .foregroundColor(isActive ? .white : .white.opacity(0.6))
                .padding(.horizontal)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: isActive ? enabledRadius : disabledRadius)
                        .stroke()
                )
                .background(secondaryLightColor)
        }
        .cornerRadius(isActive ? enabledRadius : disabledRadius)
        .tint(secondaryLightColor)
        .shadow(radius: 3)
    }
}

struct GenericButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GenericButton(txt: "Create") {
                // Do something
            }
            GenericButtonOutline(txt: "Close") {
                // Do something
            }
            ConditionalButton(txt: "Login", isActive: .constant(false)) {
                // Do something
            }
        }
    }
}
