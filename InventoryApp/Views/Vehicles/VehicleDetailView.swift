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
    @State var editMode = true
    @State var selectedNote = NoteSection.general
    @State var showingDefaultAttributes = true
    @State var selectedColor: Color
    @State var selectedYear: Int
    @State var collapse = false
    let saveFunc: (VehicleItem) -> Void
    let charLengthVIN = 17
    var cardGradient = LinearGradient(gradient: Gradient(colors: [royalPurpleMonoC, royalPurpleComplA]),
                                      startPoint: .bottomLeading, endPoint: .topTrailing)
    var backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(hex: "7550bc"), Color(hex: "1c067d")]),
                                         startPoint: .topLeading, endPoint: .bottomLeading)
    @Environment(\.managedObjectContext) private var viewContext

    init(vehicle: VehicleItem, saveFunc: @escaping (VehicleItem) -> Void) {
        /* Note: this runs multiple times when DatePicker is updated */
        self._vehicle = StateObject(wrappedValue: vehicle)
        self._selectedDate = State(initialValue: DateFormatter.formate.date(from: vehicle.tagExp) ?? Date())
        self._selectedYear = State(initialValue: Int(vehicle.year) ?? 2_023)
        self._selectedColor = State(initialValue: convertStringToColor(vehicle.color))
        self.saveFunc = saveFunc
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

    func vehicleVINHasChanged(_ oldVin: String, _ newVin: String) {
        // perform input validation
        let validatedString = String(newVin.uppercased().prefix(17))
        // update UI
        self.vehicle.vin = validatedString
        // save to core data if data is different
        if validatedString.count == 17 && oldVin.uppercased() != validatedString {
            saveFunc(vehicle)
        }
    }

    func vehicleColorHasChanged(_ color: Color) {
        // update UI
        vehicle.color = convertColorToString(color)
        // save to core data if data is different
        saveFunc(vehicle)
    }

    func vehicleYearHasChanged(_ newYear: Int) {
        // update UI
        self.vehicle.year = String(newYear)
        // save to core data if data is different
        saveFunc(vehicle)
    }

    func vehicleGenNoteHasChanged(_ note: String) {
        // update UI
        self.vehicle.genNotes = note
        // save to core data if data is different
        saveFunc(vehicle)
    }

    func vehicleMechNoteHasChanged(_ note: String) {
        // update UI
        self.vehicle.mechNotes = note
        // save to core data if data is different
        saveFunc(vehicle)
    }

    func vehicleMakeHasChanged(_ make: String) {
        // update UI
        self.vehicle.make = make
        // save to core data if data is different
        saveFunc(vehicle)
    }

    func vehicleTagExpHasChanged(_ tagExp: String) {
        // update UI
        self.vehicle.tagExp = tagExp
        // save to core data if data is different
        saveFunc(vehicle)
    }

    func vehicleModelHasChanged(_ model: String) {
        // update UI
        self.vehicle.model = model
        // save to core data if data is different
        saveFunc(vehicle)
    }

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                DetailHeaderView(headerText: "\(vehicle.year) \(vehicle.make) \(vehicle.model)",
                                 $editMode, $showingDefaultAttributes, $collapse)
                if !collapse {
                    Color.white
                        .frame(height: 0.3)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    VStack {
                        TabView {
                            Attribute1Panel(_vehicle, editMode, $selectedDate, $selectedColor)
                                .offset(y: -20)
                            Attribute2Panel(_vehicle, editMode, $selectedYear)
                                .offset(y: -20)
                        }
                        .background(cardGradient)
                        .cornerRadius(10)
                        .padding(.horizontal, 25)
                        .frame(height: 180)
                        .tabViewStyle(PageTabViewStyle())
                        .shadow(radius: 3)
                        Spacer()
                            .frame(height: 0)
                    }
                }
                VehicleNotesView(_vehicle, editMode, $selectedNote)
                    .padding(.top, collapse ? -20 : -10)
                Spacer()
            }
            .onChange(of: selectedColor, perform: vehicleColorHasChanged(_:))
            .onChange(of: selectedYear, perform: vehicleYearHasChanged(_:))
            .onChange(of: vehicle.genNotes, perform: vehicleGenNoteHasChanged(_:))
            .onChange(of: vehicle.mechNotes, perform: vehicleMechNoteHasChanged(_:))
            .onChange(of: vehicle.make, perform: vehicleMakeHasChanged(_:))
            .onChange(of: vehicle.model, perform: vehicleModelHasChanged(_:))
            .onChange(of: vehicle.tagExp, perform: vehicleTagExpHasChanged(_:))
            .onChange(of: vehicle.vin) { [oldVin = vehicle.vin] newVin in
                self.vehicleVINHasChanged(oldVin, newVin)
            }
        }

        .navigationBarHidden(true)
    }

    struct Attribute1Panel: View {
        @StateObject var vehicle: VehicleItem
        var editMode: Bool
        @Binding var selectedDate: Date
        @Binding var selectedColor: Color

        init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool, _ selectedDate: Binding<Date>,
             _ selectedColor: Binding<Color>) {
            self.editMode = editMode
            self._vehicle = vehicle
            self._selectedDate = selectedDate
            self._selectedColor = selectedColor
        }

        var body: some View {
            VStack {
                HStack {
                    AttributeLabel("VIN:")
                    Spacer()
                    TextField("VIN", text: $vehicle.vin)
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
                ColorPicker(selection: $selectedColor, supportsOpacity: true) {
                    Text("Color:")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
                .disabled(!editMode)
                .padding(.trailing, 10)
                .padding(.horizontal)
            }
        }
    }

    struct VehicleNotesView: View {
        @Environment(\.managedObjectContext) private var viewContext
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
                    VStack {
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
                }
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
                        .frame(width: 15, height: 15)
                        .tint(.white)
                }
                .tint(.gray)
                Spacer()
                Text(headerText)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Button {
                    withAnimation {
                        collapse.toggle()
                    }
                } label: {
                    Image(systemName: !collapse ? "chevron.down" : "chevron.up")
                        .resizable()
                        .frame(width: 15, height: 8)
                        .offset(y: 1)
                        .tint(primaryLightColor)
                }
                .tint(.gray)
                Spacer()
                Button {
                    editMode.toggle()
                } label: {
                    Image(systemName: editMode ? "pencil.line" : "pencil.slash")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .tint(editMode ? primaryLightColor : .white)
                }
                .tint(.gray)
            }
            .padding(.horizontal, 30)
        }
    }

    struct Attribute2Panel: View {
        @Environment(\.managedObjectContext) private var viewContext
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
                    .tint(.white)
                    .foregroundColor(.white)
                    .disabled(!editMode)
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
            .frame(width: 200, height: 30)
            .background(.black)
            .cornerRadius(7)
            .shadow(radius: 10)
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
        VehicleDetailView(vehicle: VehicleItem()) { _ in 
            //
        }
    }
}
