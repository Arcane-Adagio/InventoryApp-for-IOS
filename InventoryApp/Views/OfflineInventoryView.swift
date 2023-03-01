//
//  OfflineInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/13/23.
//

import Foundation
import SwiftUI

struct OfflineInventoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var vehicles: [VehicleItem] = []
    @State var showTestSheet = false
    @State var showDetailSheet = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CDVehicleItem.id, ascending: true)],
        animation: .default)

    private var items2: FetchedResults<CDVehicleItem>

    init() {
        _vehicles = State(initialValue: CDVehicleItem.fetchVehicleItems())
    }

    var floatingActionButton: some View {
        Button {
            if items2.count > 9 {
                CDVehicleItem.clearData()
                PersistenceController.shared.saveData()
            } else {
                addVehicleItem()
            }
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .background(secondaryLightColor)
                .clipShape(Circle())
        }
        .tint(secondaryLightColor)
        .shadow(radius: 3)
        .padding(.vertical, 50)
        .padding(.horizontal, 40)
    }

    var emptyInventoryView: some View {
        VStack {
            Spacer()
            ZStack {
                primaryDarkColor.opacity(0.3)
                    .frame(height: 100)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                Text("No Inventories to Show")
                    .shadow(radius: 3)
            }
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
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
                                VehicleItemView(vehicle: vehicle, moreInfo: detailView)
                                // Draws a background stroke around each list item
                                    .listRowBackground(
                                        EmptyView()
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
                                    )
                                // Adjusts the position of the title and icon in the row
                                    .listRowInsets(.init(top: 5, leading: 0, bottom: 10, trailing: 20))
                                // Does something important
                                    .listRowSeparator(.hidden)
                                    .listStyle(.plain)
                            }
                            // List modifier to allow swipe to delete
                            .onDelete { indexSet in
//                                for index in indexSet {
//                                    let veh = vehicles[index]
//                                    let aaa: [CDVehicleItem] = CDVehicleItem.fetchCDVehicleItemById(id: veh.id)
//                                    viewContext.delete(aaa[0])
//                                }
                                for index in indexSet {
//                                    let aaa: [CDVehicleItem] = CDVehicleItem.fetchCDVehicleItemById(id: vehicles[index].id)
                                    vehicles.remove(at: index)
                                    saveList()
                                }
//                                indexSet.map { vehicles[$0] }.forEach { vehicle in
//                                    if let index = vehicles.firstIndex(of: vehicle) {
//                                        vehicles.remove(at: index)
//                                    }
////                                    vehicles.remove(atOffsets: indexSet)
////                                    vehicles.removeAll(where: $0.id == vehicle.id)
////                                    _ = CDVehicleItem.deleteCDVehicleItemById(id: vehicle.id)
////                                    viewContext.delete(vehicle)
////                                    PersistenceController.shared.saveData()
/////                                    saveList()
//                                }
                            }
                        }
                        // Prevents List style from overriding background
                        .scrollContentBackground(.hidden)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        floatingActionButton
                    }
                }
            }
            .navigationTitle("Offline Inventories")
        }
        .tint(primaryLightColor)
        .sheet(isPresented: $showTestSheet) {
            VehicleCreationView($vehicles)
        }
    }

    func saveList() {
        DispatchQueue.main.async {
            CDVehicleItem.clearData()
            for vehicle in vehicles {
                let newItem = CDVehicleItem(context: viewContext)
                newItem.assignVehicleItem(vehicle)
            }
            do {
                try viewContext.save()
            } catch {
                //
            }
        }
    }

    var oldBody: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                HStack {
                    if items2.isEmpty {
                        emptyInventoryView
                    } else {
                        List {
                            ForEach(items2) { item in
                                let num: Int? = items2.firstIndex(of: item)
                                NavigationLink {
                                    BackgroundView()
                                } label: {
                                    HStack {
                                        Text("Inventory #\(num!)")
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    .frame(height: 35)
                                }
                                // Draws a background stroke around each list item
                                .listRowBackground(
                                    EmptyView()
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
                                )
                                // Adjusts the position of the title and icon in the row
                                .listRowInsets(.init(top: 5, leading: 0, bottom: 10, trailing: 20))
                                // Does something important
                                .listRowSeparator(.hidden)
                                .listStyle(.plain)
                            }
                            // List modifier to allow swipe to delete
                            .onDelete { indexSet in
                                indexSet.map { items2[$0] }.forEach { vehicle in
                                    vehicles.remove(atOffsets: indexSet)
//                                    vehicles.removeAll(where: $0.id == vehicle.id)
                                    _ = CDVehicleItem.deleteCDVehicleItemById(id: vehicle.id!)
//                                    viewContext.delete(vehicle)
//                                    PersistenceController.shared.saveData()
                                }
                            }
                        }
                        // Prevents List style from overriding background
                        .scrollContentBackground(.hidden)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        floatingActionButton
                    }
                }
            }
            .navigationTitle("Offline Inventories")
        }
        .tint(primaryLightColor)
        .sheet(isPresented: $showTestSheet) {
            VehicleCreationView($vehicles)
        }
    }

    private func addItem() {
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

    private func addVehicleItem(_ vehicleItem: VehicleItem = VehicleItem()) {
        withAnimation {
//            self.vehicles.append(vehicleItem)
            CDVehicleItem.addVehicleItem(vehicleItem)
        }
    }

    private func deleteVehicleItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { items2[$0] }.forEach(
                viewContext.delete
//                CDVehicleItem.deleteCDVehicleItemById(id: $0.id)
//                addVehicleItem()
            )
//            CDVehicleItem.addVehicleItem(vehicleItem)
//            CDVehicleItem.deleteCDVehicleItemById(id: vehicleItem.id)
            do {
                try viewContext.save()
            } catch {
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { items2[$0] }.forEach(viewContext.delete)
            vehicles = []
            do {
                try viewContext.save()
            } catch {
                //
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

struct OfflineInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineInventoryView()
    }
}
