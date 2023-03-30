//
//  VehicleDetailView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/18/23.
//

import SwiftUI

struct VehicleDetailView: View {
    @StateObject var vehicle: VehicleItem
    @State var entryVIN = "JASOIDJAPSODI"
    @State var entryTagEx = "03/24"
    @State var entryColor = "Gold"
    @State var notesText = ""
    @State var mechanicText = ""
    @State var editMode = false
    let charLengthVIN = 17
    @Environment(\.dismiss) var dismiss

    struct AttributeLabel: View {
        var labelText: String

        init(_ labelText: String) {
            self.labelText = labelText
            UITextView.appearance().backgroundColor = .clear
        }

        var body: some View {
            Text(labelText)
                .font(.system(size: 16, weight: .bold, design: .rounded))
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [Color(hex: "7550bc"), Color(hex: "1c067d")]),
                           startPoint: .topLeading, endPoint: .bottomLeading)
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(.white)
                    }
                    .tint(.gray)
                    Spacer()
                    Text("\(vehicle.year) \(vehicle.make) \(vehicle.model)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
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
                }
                .padding([.horizontal, .top])

                Color.white
                    .frame(height: 0.3)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    VStack {
                        HStack {
                            AttributeLabel("VIN:")
                            TextField("VIN", text: $vehicle.vin.max(charLengthVIN + 3))
                                // Only allow textField editing while in Edit Mode
                                .disabled(!editMode)
                                // Align the textfield to the right of the view
                                .multilineTextAlignment(.trailing)
                                // set the font to look nice
                                .font(.system(size: 14, weight: .light, design: .rounded))
                                // Change color of text if VIN is invalid
                                .foregroundColor(vehicle.vin.count <= charLengthVIN + 1 ? .white : .red )
                        }
                        .padding(.horizontal)
                        HStack {
                            AttributeLabel("Tag expiraiton:")
                            TextField("MM/YY", text: $vehicle.tagExp.max(5))
                                // Only allow textField editing while in Edit Mode
                                .disabled(!editMode)
                                // Align the textfield to the right of the view
                                .multilineTextAlignment(.trailing)
                                // set the font to look nice
                                .font(.system(size: 14, weight: .light, design: .rounded))
                        }
                        .padding(.horizontal)
                        HStack {
                            AttributeLabel("Color:")
                            TextField("VIN", text: $vehicle.color)
                                // Only allow textField editing while in Edit Mode
                                .disabled(!editMode)
                                // Align the textfield to the right of the view
                                .multilineTextAlignment(.trailing)
                                // set the font to look nice
                                .font(.system(size: 14, weight: .light, design: .rounded))
                        }
                        .padding(.horizontal)
                        Spacer()
                            .frame(height: 30)
                        HStack {
                            Text("Notes:")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .padding(.leading)
                        Color.white
                            .frame(height: 0.3)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        ScrollView {
                            VStack {
                                VStack {
                                    HStack {
                                        Text("General:")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                            .padding(.top)
                                        Spacer()
                                    }
                                    .padding(.leading)
                                    IOS15TextField(editMode: editMode, text: $vehicle.genNotes)
                                }
                                .padding(.bottom)
                                VStack {
                                    HStack {
                                        Text("Mechanical notes:")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                        Spacer()
                                    }
                                    .padding(.leading)
                                    IOS15TextField(editMode: editMode, text: $vehicle.mechNotes)
                                }
                            }
                        }
                        .frame(height: 250)
                        Spacer()
                    }
            }
            .padding(.vertical)
            .padding(.top, 20)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

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
            HStack {
                Text(text)
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.leading, 5)
                Spacer()
            }
        }
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView(vehicle: VehicleItem())
    }
}
