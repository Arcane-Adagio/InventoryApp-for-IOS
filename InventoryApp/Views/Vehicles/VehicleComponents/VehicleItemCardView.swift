//
//  VehicleItemCardView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/30/23.
//

import Foundation
import SwiftUI

struct VehicleItemCardView: View {
    @StateObject var vehicle: VehicleItem
    var editMode: Bool
    @State var activeTab = 1
    @State var isPresentingConfirm = false
    @State var showDetailSheet = false
    @Environment(\.managedObjectContext) private var viewContext

    init(_ vehicle: VehicleItem, _ editMode: Bool) {
        self.editMode = editMode
        self._vehicle = StateObject(wrappedValue: vehicle)
    }

    let cardGradient = LinearGradient(gradient: Gradient(colors: [royalPurpleMonoC, royalPurpleComplA]),
                                      startPoint: .bottomLeading, endPoint: .topTrailing)
    var body: some View {
        ZStack {
            TabView(selection: $activeTab) {
                Attribute2Panel(_vehicle, editMode)
                    .offset(y: -5)
                    .tag(1)
                    .disabled(activeTab != 1)
                Attribute1Panel(_vehicle, editMode)
                    .offset(y: -5)
                    .tag(2)
                    .disabled(activeTab != 2)
            }
            VStack {
                HStack {
                    Button {
                        showDetailSheet = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding([.top], 15)
                    .padding([.horizontal], 20)
                    Spacer()
                    Button {
                        isPresentingConfirm = true
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding([.top], 15)
                    .padding([.horizontal], 20)
                    .confirmationDialog("",
                                        isPresented: $isPresentingConfirm) {
                        Button("Delete Vehicle", role: .destructive) {
                            OfflineVehicleInventoryViewModel.singleton.deleteVehicleItem(vehicle, context: viewContext)
                        }
                    }
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $showDetailSheet) {
                VehicleDetailView(vehicle: vehicle, compacted: true, editMode: editMode)
            }
        }
        .background(cardGradient)
        .cornerRadius(10)
        .padding(.horizontal, 25)
        .frame(height: 230)
        .tabViewStyle(PageTabViewStyle())
        .shadow(radius: 3)
    }

    struct Attribute1Panel: View {
        var vehicleViewModel = OfflineVehicleInventoryViewModel.singleton
        @Environment(\.managedObjectContext) private var viewContext
        @StateObject var vehicle: VehicleItem
        var editMode: Bool
        @State var selectedDate: Date
        @State var selectedColor: Color

        init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool) {
            self.editMode = editMode
            self._vehicle = vehicle
            self._selectedDate = State(initialValue: DateFormatter
                .formate.date(from: vehicle.wrappedValue.tagExp) ?? Date())
            self._selectedColor = State(initialValue: convertStringToColor(vehicle.wrappedValue.color))
        }

        var body: some View {
            VStack {
                HStack {
                    Text("VIN:")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
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
                        .onChange(of: vehicle.vin) { [oldVin = vehicle.vin] newVin in
                            // perform input validation
                            let validatedString = String(newVin.uppercased().prefix(17))
                            // update UI
                            self.vehicle.vin = validatedString
                            // save to core data if data is different
                            if validatedString.count == 17 && oldVin.uppercased() != validatedString {
                                vehicleViewModel.modifyCoreDate(vehicle, context: viewContext)
                            }
                        }
                }
                .padding(.horizontal)
                HStack {
                    MyDatePicker(label: "Tag Expiration:", date: $selectedDate) { date in
                        vehicle.tagExp = DateFormatter.formate.string(from: date)
                    }
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .disabled(!editMode)
                    .padding(.bottom, 3)
                    .onChange(of: selectedDate) { date in
                        // update UI
                        self.vehicle.tagExp = DateFormatter.formate.string(from: date)
                        // save to core data if data is different
                        vehicleViewModel.modifyCoreDate(vehicle, context: viewContext)
                    }
                }
                .padding(.horizontal)
                ColorPicker(selection: $selectedColor, supportsOpacity: true) {
                    Text("Color:")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
                .disabled(!editMode)
                .padding(.trailing, 10)
                .padding(.horizontal)
                .onChange(of: selectedColor) { newColor in
                    // update UI
                    vehicle.color = convertColorToString(newColor)
                    // save to core data if data is different
                    vehicleViewModel.modifyCoreDate(vehicle, context: viewContext)
                }
            }
        }
    }

    struct Attribute2Panel: View {
        @Environment(\.managedObjectContext) private var viewContext
        @StateObject var vehicle: VehicleItem
        var vehicleViewModel = OfflineVehicleInventoryViewModel.singleton
        var editMode: Bool
        @State var selectedYear: Int

        init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool) {
            self.editMode = editMode
            self._vehicle = vehicle
            self._selectedYear = State(initialValue: Int(vehicle.wrappedValue.year) ?? 2_023)
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
                    .onChange(of: selectedYear) { newYear in
                        self.vehicle.year = String(newYear)
                        vehicleViewModel.modifyCoreDate(vehicle, context: viewContext)
                    }
                HStack {
                    Text("Make:")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Spacer()
                    TextField("Make", text: $vehicle.make)
                        .disabled(!editMode)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16, weight: .none, design: .rounded))
                        .background(editMode ? editOverlay : nil)
                        .onChange(of: vehicle.make) { make in
                            self.vehicle.make = make
                            vehicleViewModel.modifyCoreDate(vehicle, context: viewContext)
                        }
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Model:")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Spacer()
                    TextField("Model", text: $vehicle.model)
                        .disabled(!editMode)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16, weight: .none, design: .rounded))
                        .background(editMode ? editOverlay : nil)
                        .padding(.trailing, 10)
                        .onChange(of: vehicle.model) { model in
                            self.vehicle.model = model
                            vehicleViewModel.modifyCoreDate(vehicle, context: viewContext)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            VehicleItemCardView(VehicleItem(), false)
        }
    }
}
