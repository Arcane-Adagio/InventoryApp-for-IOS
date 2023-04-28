//
//  VehicleAttributeCardView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/28/23.
//

import Foundation
import SwiftUI

struct VehicleAttributeCardView: View {
    @StateObject var vehicle: VehicleItem
    @Binding var selectedDate: Date
    var editMode: Bool
    @Binding var selectedColor: Color
    @Binding var selectedYear: Int

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

    init(_ vehicle: StateObject<VehicleItem>, _ editMode: Bool, _ selectedYear: Binding<Int>,
         _ selectedColor: Binding<Color>, _ selectedDate: Binding<Date>) {
        self.editMode = editMode
        self._vehicle = vehicle
        self._selectedYear = selectedYear
        self._selectedColor = selectedColor
        self._selectedDate = selectedDate
    }

    let cardGradient = LinearGradient(gradient: Gradient(colors: [royalPurpleMonoC, royalPurpleComplA]),
                                      startPoint: .bottomLeading, endPoint: .topTrailing)
    var body: some View {
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

struct VehicleAttributeCardView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleAttributeCardView(.init(wrappedValue: VehicleItem()), true,
                                 .constant(2_011), .constant(.red), .constant(Date()))
    }
}
