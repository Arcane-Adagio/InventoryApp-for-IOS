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
    let charLengthVIN = 17
    @Environment(\.dismiss) var dismiss

    init(vehicle: VehicleItem) {
        self._vehicle = StateObject(wrappedValue: vehicle)
        self._selectedDate = State(initialValue: DateFormatter.formate.date(from: vehicle.tagExp) ?? Date())
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

    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [Color(hex: "7550bc"), Color(hex: "1c067d")]),
                           startPoint: .topLeading, endPoint: .bottomLeading)
            VStack {
                headerView
                Color.white
                    .frame(height: 0.3)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    VStack {
                        if showingDefaultAttributes {
                            attributesView
                        } else {
                            editVehicleView
                        }
                        Spacer()
                            .frame(height: 30)
                        notesView
                        Spacer()
                    }
            }
            .padding(.vertical)
            .padding(.top, 20)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    private var attributesView: some View {
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
                MyDatePicker(label: "Tag Expiration", date: $selectedDate) { date in
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

    private var notesView: some View {
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

    private var headerView: some View {
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
                    showingDefaultAttributes.toggle()
                }
            } label: {
                Text("\(vehicle.year) \(vehicle.make) \(vehicle.model)")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(editMode ? 10 : 0)
                    .background(editMode ? editColor : nil)
                    .cornerRadius(15)
            }
            .foregroundColor(.white)
            .disabled(!editMode)
            .tint(.white)
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

    // TODO: this
    private var editVehicleView: some View {
        VStack {
            Text("To Do")
        }
    }
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
