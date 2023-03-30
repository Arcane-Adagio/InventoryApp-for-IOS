//
//  InventoryItem.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/15/23.
//

import SwiftUI

struct InventoryItemView: View {
    @ObservedObject var itemInfo: InventoryItem
    @State var checked = true
    @State var name = ""
    @State var quantityOH = ""
    @State var quantityRS = ""
    @State var date = ""
    @State var note = ""
    let horizontalIconPadding: CGFloat = 10
    let itemHorizontalPadding: CGFloat = 15
    let iconSize: CGFloat = 23
    var onClick: () -> Void

    var body: some View {
        VStack {
            HStack {
                if itemInfo.checkable {
                    Toggle(isOn: $checked) {}
                        .toggleStyle(IOSCheckboxToggleStyle())
                        .tint(.white)
                        .frame(width: iconSize, height: iconSize)
                        .padding(.leading, horizontalIconPadding + 5)
                        .padding(.trailing, horizontalIconPadding)
                }
                VStack {
                    GenericTextView(hint: "Item name", userInput: $itemInfo.name, fontSize: 16)
                        .padding(.top, 10)
                        .padding(.bottom, -5)
                    HStack {
                        Text("On Hand:")
                            .font(.system(size: 12, weight: .light, design: .rounded))
                            .frame(width: 33)
                            .padding(.bottom, 10)
                        InputNumberView(hint: "Qty", userInput: $itemInfo.quantityOH)
                            .multilineTextAlignment(.center)
                        Text("Restock Qty:")
                            .font(.system(size: 12, weight: .light, design: .rounded))
                            .frame(width: 44)
                            .padding(.bottom, 10)
                        InputNumberView(hint: "Qty", userInput: $itemInfo.quantityRS)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 10, weight: .light, design: .rounded))
                    }
                    if !note.isEmpty {
                        IOS15TextField(editMode: true, text: $note)
                    }
                }
                .padding(.leading, itemInfo.checkable ? 0 : 15)
                Button {
                    onClick()
                } label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: itemInfo.checkable ? iconSize : 18,
                               height: itemInfo.checkable ? iconSize : 18)
                        .padding(.trailing, itemInfo.checkable ? horizontalIconPadding + 5
                                 : horizontalIconPadding + 5)
                        .padding(.leading, itemInfo.checkable ? horizontalIconPadding
                                 : horizontalIconPadding - 0)
                }
                .foregroundColor(.white)
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
    static let sampleItem = InventoryItem(name: "5.56 Pizza Rolls", quantityOH: "5", quantityRS: "10")
    static var previews: some View {
        ZStack {
            BackgroundView()
            InventoryItemView(itemInfo: sampleItem) {
                // some function for when 'more info' is tapped
            }
        }
    }
}

struct IOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle" : "circle")
                    .resizable()
                configuration.label
            }
        })
    }
}
