//
//  VehicleCreationView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/19/23.
//

import SwiftUI

struct VehicleCreationView: View {
    @State var entryYear = ""
    @State var entryModel = ""
    @State var entryMake = ""
    @State var entryVIN = ""
    @State var entryTagEx = ""
    @State var entryColor = ""
    @State var notesText = ""
    @State var mechanicText = ""
    @State var prompt: Fragments = .initial
    @Binding var vehicleList: [VehicleItem]
    @Environment(\.dismiss) var dismiss

    @State var fragmentStack = Stack<Fragments>()
    let charLengthVIN = 17
    let textFieldFontSize: CGFloat = 14

    var requirementsMet: Bool {
        entryYear.count > 2
        && !entryModel.isEmpty
        && !entryMake.isEmpty
        && entryVIN.count >= 15
        && !entryTagEx.isEmpty
        && !entryColor.isEmpty
    }

    init(_ vehicleList: Binding<[VehicleItem]>) {
        self._vehicleList = vehicleList
        fragmentStack.push(.initial)
    }

    enum Fragments {
        case initial, notes
    }

    func backBtnBehavior() {
        /* Make the back button use the stack if adding another fragment
         to this view */
        prompt = .initial
    }

    func nextBtnBehavior() {
        fragmentStack.push(.notes)
        prompt = .notes
    }

    func submitBtnBehavior() {
        vehicleList.append(
            VehicleItem(year: entryYear,
                        make: entryMake,
                        model: entryModel,
                        vin: entryVIN,
                        tagExp: entryTagEx,
                        color: entryColor,
                        genNotes: notesText,
                        mechNotes: mechanicText
        ))
        dismiss()
    }

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
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "7550bc"), Color(hex: "1c067d")]),
                startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        Text(prompt == .initial ? "New Vehicle (Required)" : "New Vehicle (Optional)")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .padding(.top)
                            .padding(.bottom, 30)
                        switch prompt {
                        case .initial:
                            InputNumberView(hint: "Year", userInput: $entryYear)
                                .multilineTextAlignment(.leading)
                                .onReceive(entryYear.publisher.collect()) {
                                    self.entryYear = String($0.prefix(4))
                                }
                            InputTextView(hint: "Make", userInput: $entryMake, fontSize: textFieldFontSize)
                                .onReceive(entryMake.publisher.collect()) {
                                    self.entryMake = String($0.prefix(15))
                                }
                            InputTextView(hint: "Model", userInput: $entryModel, fontSize: textFieldFontSize)
                                .onReceive(entryModel.publisher.collect()) {
                                    self.entryModel = String($0.prefix(15))
                                }
                            InputTextView(hint: "VIN", userInput: $entryVIN, fontSize: textFieldFontSize)
                                .textCase(.uppercase)
                                // Change color of text if VIN is invalid
                                .foregroundColor(entryVIN.count <= charLengthVIN + 1 ? .white : .red )
                                // Set maximum characters as Valid VIN + 3
                                .onReceive(entryVIN.publisher.collect()) {
                                    self.entryVIN = String($0.prefix(charLengthVIN + 3))
                                }
                            InputTextView(hint: "Tag Exp in MM/YY format",
                                          userInput: $entryTagEx, fontSize: textFieldFontSize)
                                // Set maximum characters as 5
                                .onReceive(entryTagEx.publisher.collect()) {
                                    self.entryTagEx = String($0.prefix(5))
                                }
                            InputTextView(hint: "Color", userInput: $entryColor, fontSize: textFieldFontSize)
                                // Set maximum characters as 5
                                .onReceive(entryColor.publisher.collect()) {
                                    self.entryColor = String($0.prefix(15))
                                }
                        default:
                            ScrollView {
                                VStack {
                                    HStack {
                                        Text("General:")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                        Spacer()
                                    }
                                    TextField("Enter general notes here",
                                              text: $notesText, axis: .vertical)
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                                    .lineLimit(nil)
                                }
                                VStack {
                                    HStack {
                                        Text("Mechanical notes:")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                        Spacer()
                                    }
                                    TextField("Enter mechanical notes here",
                                              text: $mechanicText, axis: .vertical)
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                                    .lineLimit(nil)
                                }
                                .padding(.vertical)
                            }
                            .frame(height: 225)
                        }
                    }

                    HStack {
                        GenericButton(txt: "Back", action: backBtnBehavior)
                            // The back button should show on the first fragment
                            .disabled(prompt == .initial)
                            .opacity(prompt == .initial ? 0 : 1)
                        Spacer()
                            .frame(width: prompt == .initial ? 200 : 10)
                        GenericButton(
                            txt: prompt == .notes ? "Submit" : "Next",
                            action: prompt == .notes ? submitBtnBehavior : nextBtnBehavior)
                            .disabled(!requirementsMet)
                    }
                    .padding()
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VehicleCreationView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleCreationView(.constant([VehicleItem(), VehicleItem()]))
    }
}
