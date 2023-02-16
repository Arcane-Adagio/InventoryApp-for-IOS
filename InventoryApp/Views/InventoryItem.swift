//
//  InventoryItem.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/15/23.
//

import SwiftUI

struct InventoryItem: View {
    @State var checked = true
    @State var name = ""
    @State var quantity = ""
    @State var date = ""
    @State var note = ""
    let horizontalIconPadding: CGFloat = 5
    let itemHorizontalPadding: CGFloat = 15
    var body: some View {
        VStack {
            HStack {
                Toggle(isOn: $checked) {}
                    .toggleStyle(IOSCheckboxToggleStyle())
                    .tint(.white)
                    .padding(.leading, horizontalIconPadding + 10)
                    .padding(.trailing, horizontalIconPadding)
                VStack {
                    GenericTextView(hint: "Item name", userInput: $name)
                        .padding(.top, 10)
                    HStack {
                        GenericTextView(hint: "Date", userInput: $date)
                        GenericTextView(hint: "Quantity", userInput: $quantity)
                    }
                    if !note.isEmpty {
                        TextField("Note", text: $note, axis: .vertical)
                            .textFieldStyle(.plain)
                            .textFieldStyle(.roundedBorder)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom, 10)
                    }
                }
                if note.isEmpty {
                    Image(systemName: "note.text.badge.plus")
                        .padding(.leading, 5)
                }
                Image(systemName: "chevron.down")
                    .padding(.trailing, horizontalIconPadding + 10)
                    .padding(.leading, horizontalIconPadding)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke()
        )
        .padding(
            EdgeInsets(
                top: 2,
                leading: 2,
                bottom: 2,
                trailing: 2
            )
        )
        .padding(.horizontal, 15)
    }
}

struct InventoryItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            InventoryItem()
        }
    }
}

struct IOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}
