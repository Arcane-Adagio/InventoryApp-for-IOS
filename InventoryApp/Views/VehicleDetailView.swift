//
//  VehicleDetailView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/18/23.
//

import SwiftUI

struct VehicleDetailView: View {
    @State var entryVIN = "JASOIDJAPSODI"
    @State var entryTagEx = "03/24"
    @State var entryColor = "Gold"
    @State var notesText = ""
    @State var mechanicText = ""
    @State var editMode = false
    let charLengthVIN = 17

    struct AttributeLabel: View {
        var labelText: String

        init(_ labelText: String) {
            self.labelText = labelText
        }

        var body: some View {
            Text(labelText)
                .font(.system(size: 16, weight: .bold, design: .rounded))
        }
    }

    var body: some View {
        ZStack {
            primaryDarkColor
            VStack {
                HStack {
                    Spacer()
                    Button {
                        editMode.toggle()
                    } label: {
                        Image(systemName: editMode ? "pencil.line" : "pencil.slash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(editMode ? primaryLightColor : .white)
                    }
                    .tint(.gray)
                    .padding()
                }

                    VStack {
                        Text("2006 Honda Pilot")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.bottom)
                        HStack {
                            AttributeLabel("VIN:")
                            TextField("VIN", text: $entryVIN)
                                // Only allow textField editing while in Edit Mode
                                .disabled(!editMode)
                                // Align the textfield to the right of the view
                                .multilineTextAlignment(.trailing)
                                // set the font to look nice
                                .font(.system(size: 14, weight: .light, design: .rounded))
                                // Change color of text if VIN is invalid
                                .foregroundColor(entryVIN.count <= charLengthVIN + 1 ? .white : .red )
                                // Set maximum characters as Valid VIN + 3
                                .onReceive(entryVIN.publisher.collect()) {
                                    self.entryVIN = String($0.prefix(charLengthVIN + 3))
                                }
                        }
                        .padding(.horizontal)
                        HStack {
                            AttributeLabel("Tag expiraiton:")
                            TextField("MM/YY", text: $entryTagEx)
                                // Only allow textField editing while in Edit Mode
                                .disabled(!editMode)
                                // Align the textfield to the right of the view
                                .multilineTextAlignment(.trailing)
                                // set the font to look nice
                                .font(.system(size: 14, weight: .light, design: .rounded))
                                // Set maximum characters as 5
                                .onReceive(entryTagEx.publisher.collect()) {
                                    self.entryTagEx = String($0.prefix(5))
                                }
                        }
                        .padding(.horizontal)
                        HStack {
                            AttributeLabel("Color:")
                            TextField("VIN", text: $entryColor)
                                // Only allow textField editing while in Edit Mode
                                .disabled(!editMode)
                                // Align the textfield to the right of the view
                                .multilineTextAlignment(.trailing)
                                // set the font to look nice
                                .font(.system(size: 14, weight: .light, design: .rounded))
                                // Set maximum characters as whatever that isn't egregious
                                .onReceive(entryColor.publisher.collect()) {
                                    self.entryColor = String($0.prefix(15))
                                }
                        }
                        .padding(.horizontal)
                        Spacer()
                            .frame(height: 30)
                        HStack {
                            Text("Notes:")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .padding(.leading)
                        ScrollView {
                            VStack {
                                HStack {
                                    Text("General:")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                    Spacer()
                                }
                                .padding(.leading)
                                TextField(editMode ? "Enter notes here" : "No notes to show",
                                          text: $notesText, axis: .vertical)
                                    .disabled(!editMode)
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                                    .lineLimit(nil)
                                    .padding(.horizontal)
                            }
                            .padding(.top)
                            VStack {
                                HStack {
                                    Text("Mechanical notes:")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                    Spacer()
                                }
                                .padding(.leading)
                                TextField(editMode ? "Enter notes here" : "Nothing from the mechanic",
                                          text: $mechanicText, axis: .vertical)
                                    .disabled(!editMode)
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                                    .lineLimit(nil)
                                    .padding(.horizontal)
                            }
                            .padding(.vertical)
                        }
//                        Spacer()
                    }
            }
        }
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView()
    }
}
