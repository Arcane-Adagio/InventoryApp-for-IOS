//
//  VehicleDetailView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/18/23.
//

import SwiftUI

struct VehicleDetailView: View {
    @StateObject var vehicle: VehicleItem
    @State var selectedDate: Date
    @State var editMode = false
    @State var selectedNote = NoteSection.general
    @State var showingDefaultAttributes = true
    @State var selectedYear: Int
    @State var collapse = true
    let charLengthVIN = 17

    init(vehicle: VehicleItem) {
        self._vehicle = StateObject(wrappedValue: vehicle)
        self._selectedDate = State(initialValue: DateFormatter.formate.date(from: vehicle.tagExp) ?? Date())
        self._selectedYear = State(initialValue: Int(vehicle.year) ?? 2_023)
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
            LinearGradient(gradient:
                            Gradient(colors: [Color(hex: "7550bc"), Color(hex: "1c067d")]),
                           startPoint: .topLeading, endPoint: .bottomLeading)
            VStack {
                DetailHeaderView(headerText: "\(vehicle.year) \(vehicle.make) \(vehicle.model)",
                                 $editMode, $showingDefaultAttributes, $collapse)
                if !collapse {
                    Color.white
                        .frame(height: 0.3)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    VStack {
                        if showingDefaultAttributes {
                            Attribute1Panel(_vehicle, editMode, $selectedDate)
                        } else {
                            Attribute2Panel(_vehicle, editMode, $selectedYear)
                        }
                        Spacer()
                            .frame(height: 30)
                    }
                }
                VehicleNotesView(_vehicle, editMode, $selectedNote)
                    .padding(.top, collapse ? -20 : 0)
                Spacer()
            }
            .padding(.vertical)
            .padding(.top, 20)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    struct Attribute1Panel: View {
        @StateObject var vehicle: VehicleItem
        var editMode: Bool
        @Binding var selectedDate: Date

        init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool, _ selectedDate: Binding<Date>) {
            self.editMode = editMode
            self._vehicle = vehicle
            self._selectedDate = selectedDate
        }

        var body: some View {
            VStack {
                HStack {
                    AttributeLabel("VIN:")
                    Spacer()
                    TextField("VIN", text: $vehicle.vin)
                        .onChange(of: vehicle.vin) { newVin in
                            self.vehicle.vin = String(newVin.uppercased().prefix(17))
                        }
                    // Only allow textField editing while in Edit Mode
                        .disabled(!editMode)
                    // Align the textfield to the right of the view
                        .multilineTextAlignment(.trailing)
                    // set the font to look nice
                        .font(.system(size: 16, weight: .none, design: .rounded))
                        .background(editMode ? editOverlay : nil)
                        .padding(.trailing, 10)
                }
                .padding(.horizontal)
                HStack {
                    MyDatePicker(label: "Tag Expiration:", date: $selectedDate) { date in
                        vehicle.tagExp = DateFormatter.formate.string(from: date)
                    }
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .disabled(!editMode)
                    .padding(.bottom, 3)
                }
                .padding(.horizontal)
                HStack {
                    AttributeLabel("Color:")
                    Spacer()
                    TextField("Color", text: $vehicle.color)
                    // Only allow textField editing while in Edit Mode
                        .disabled(!editMode)
                    // Align the textfield to the right of the view
                        .multilineTextAlignment(.trailing)
                    // set the font to look nice
                        .font(.system(size: 16, weight: .none, design: .rounded))
                        .background(editMode ? editOverlay : nil)
                        .padding(.trailing, 10)
                }
                .padding(.horizontal)
            }
        }
    }

    struct VehicleNotesView: View {
        @StateObject var vehicle: VehicleItem
        var editMode: Bool
        @Binding var selectedNote: NoteSection

        init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool, _ selectedNote: Binding<NoteSection>) {
            self.editMode = editMode
            self._vehicle = vehicle
            self._selectedNote = selectedNote
        }

        var body: some View {
            VStack {
                MyNotePicker(date: $selectedNote)
                    .padding(.horizontal, 40)
                    .padding(.top, 30)
                Color.white
                    .frame(height: 0.3)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                ScrollView {
                    switch selectedNote {
                    case NoteSection.mechanical:
                        TextField(editMode ? "Enter notes here" : "Nothing from the mechanic",
                                  text: $vehicle.mechNotes, axis: .vertical)
                        .disabled(!editMode)
                        .font(.system(size: 14, weight: .light, design: .rounded))
                        .lineLimit(nil)
                        .padding(.horizontal)
                    default:
                        TextField(editMode ? "Enter notes here" : "No notes to show",
                                  text: $vehicle.genNotes, axis: .vertical)
                        .disabled(!editMode)
                        .font(.system(size: 14, weight: .light, design: .rounded))
                        .lineLimit(nil)
                        .padding(.horizontal)
                    }
                }
                .frame(height: 250)
            }
            .padding(.horizontal, 10)
        }
    }

    struct DetailHeaderView: View {
        @Environment(\.dismiss) var dismiss
        var headerText: String
        @Binding var editMode: Bool
        @Binding var showingFirstPanel: Bool
        @Binding var collapse: Bool

        init(headerText: String, _ editMode: Binding<Bool>, _ showingFirstPanel: Binding<Bool>,
             _ collapse: Binding<Bool>) {
            self.headerText = headerText
            self._editMode = editMode
            self._showingFirstPanel = showingFirstPanel
            self._collapse = collapse
        }

        var body: some View {
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
                Button {
                    withAnimation {
                        showingFirstPanel.toggle()
                    }
                } label: {
                    Text(headerText)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(editMode ? 10 : 0)
                        .background(editMode ? editColor : nil)
                        .cornerRadius(15)
                }
                .foregroundColor(.white)
                .disabled(!editMode)
                .tint(.white)
                Button {
                    withAnimation {
                        collapse.toggle()
                    }
                } label: {
                    Image(systemName: collapse ? "chevron.down" : "chevron.up")
                        .resizable()
                        .frame(width: 20, height: 10)
                        .tint(primaryLightColor)
                }
                .tint(.gray)
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
        }
    }

    struct Attribute2Panel: View {
        @StateObject var vehicle: VehicleItem
        var editMode: Bool
        @Binding var selectedYear: Int

        init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool, _ selectedYear: Binding<Int>) {
            self.editMode = editMode
            self._vehicle = vehicle
            self._selectedYear = selectedYear
        }

        var body: some View {
            VStack {
                MyYearPicker(label: "Year:", date: $selectedYear)
                    .onChange(of: selectedYear) { newYear in
                        self.vehicle.year = String(newYear)
                    }
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .padding(.trailing, -10)
                    .padding(.top, -7)
                HStack {
                    AttributeLabel("Make:")
                    Spacer()
                    TextField("Make", text: $vehicle.make)
                        .disabled(!editMode)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16, weight: .none, design: .rounded))
                        .background(editMode ? editOverlay : nil)
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                HStack {
                    AttributeLabel("Model:")
                    Spacer()
                    TextField("Model", text: $vehicle.model)
                        .disabled(!editMode)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16, weight: .none, design: .rounded))
                        .background(editMode ? editOverlay : nil)
                        .padding(.trailing, 10)
                }
            }
            .padding(.horizontal)
        }
    }
}

private var editOverlay: some View {
    HStack {
        Spacer()
        Color.white
            .frame(width: 200, height: 35)
            .background(.black)
            .cornerRadius(10)
    }
    .opacity(0.1)
    .offset(x: 10)
}

private var editColor: some View {
    Color.white
        .background(.black)
        .opacity(0.1)
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView(vehicle: VehicleItem())
    }
}
