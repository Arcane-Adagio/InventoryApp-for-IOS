//
//  VehicleInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/28/23.
//

import SwiftUI

struct VehicleInventoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var vehicles: [VehicleItem] = []
    @State var showCreationSheet = false
    @State var showDetailSheet = false
    let debugMode = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CDVehicleItem.id, ascending: true)],
        animation: .default)

    private var items2: FetchedResults<CDVehicleItem>

    init() {
        _vehicles = State(initialValue: CDVehicleItem.fetchVehicleItems())
    }

    func detailView() {
        showDetailSheet.toggle()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                HStack {
                    if !vehicles.isEmpty {
                        List {
                            ForEach(vehicles) { vehicle in
//                                VehicleItemView(vehicle: vehicle, moreInfo: detailView, saveToCoreData: <#(VehicleItem) -> Void#>)
//                                // Draws a background stroke around each list item
//                                    .listRowBackground(
//                                        EmptyView()
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 10)
//                                                    .stroke()
//                                            )
//                                            .padding(
//                                                EdgeInsets(
//                                                    top: 2,
//                                                    leading: 2,
//                                                    bottom: 2,
//                                                    trailing: 2
//                                                )
//                                            )
//                                    )
//                                // Adjusts the position of the title and icon in the row
//                                    .listRowInsets(.init(top: 5, leading: 0, bottom: 10, trailing: 20))
//                                // Does something important
//                                    .listRowSeparator(.hidden)
//                                    .listStyle(.plain)
                            }
                            // List modifier to allow swipe to delete
                            .onDelete(perform: deleteVehicleItem(offsets:))
                        }
                        // Prevents List style from overriding background
                        .scrollContentBackground(.hidden)
                    } else {
                        EmptyInventoryView(text: "No Vehicles to Show")
                    }
                }
                FloatingActionButton(action: floatingButtonBehavior)
            }
            .navigationTitle("Vehicles")
        }
        .tint(primaryLightColor)
        .sheet(isPresented: $showCreationSheet) {
            VehicleCreationView(addVehicleItem(_:))
        }
    }

    func floatingButtonBehavior() {
        if debugMode {
            addVehicleItem()
        } else {
            showCreationSheet.toggle()
        }
    }

    func addItem() {
        withAnimation {
            let newItem = CDInventory(context: viewContext)
            newItem.name = "placerholder"
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                print("debug: no")
            }
        }
    }

    func addVehicleItem(_ vehicleItem: VehicleItem = VehicleItem()) {
        withAnimation {
            CDVehicleItem.addVehicleItem(vehicleItem)
            vehicles.append(vehicleItem)
        }
    }

    func deleteVehicleItem(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewContext.delete(items2[index])
                vehicles.remove(at: index)
                try? viewContext.save()
            }
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct VehicleInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleInventoryView()
    }
}
