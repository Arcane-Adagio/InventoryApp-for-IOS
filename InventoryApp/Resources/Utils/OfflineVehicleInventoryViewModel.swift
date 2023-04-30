//
//  OfflineVehicleInventoryViewModel.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/28/23.
//

import CoreData
import Foundation
import SwiftUI

class OfflineVehicleInventoryViewModel: ObservableObject {
    static let singleton = OfflineVehicleInventoryViewModel()
    private var items2: [CDVehicleItem]
    @Published var vehicles: [VehicleItem] = []

    private init() {
        items2 = CDVehicleItem.fetchCDVehicleItems()
        vehicles = CDVehicleItem.fetchVehicleItems()
    }

    func modifyCoreDate(_ modVehicle: VehicleItem, context: NSManagedObjectContext) {
        guard let cdVehicleIndex = items2.firstIndex(where: { $0.id ?? UUID() == modVehicle.id }) else {
            print("failed to save")
            print("here's what you gave \(modVehicle.id)")
            print("here's what's in storage: \(items2.map { $0.id ?? UUID() })")
            return
        }
        items2[cdVehicleIndex].assignVehicleItem(modVehicle)
        do {
            try context.save()
        } catch {
            print("debug: no")
        }
    }

    func addVehicleItem(_ vehicleItem: VehicleItem = VehicleItem()) {
        CDVehicleItem.addVehicleItem(vehicleItem)
        updateCDVehicleList()
        withAnimation {
            vehicles.append(vehicleItem)
        }
    }

    func deleteVehicleItem(offsets: IndexSet, context: NSManagedObjectContext) {
        withAnimation {
            for index in offsets {
                context.delete(items2[index])
                vehicles.remove(at: index)
                try? context.save()
            }
        }
    }

    func deleteVehicleItem(_ vehicleItem: VehicleItem, context: NSManagedObjectContext) {
        guard let cdVehicleIndex = items2.firstIndex(where: { $0.id ?? UUID() == vehicleItem.id }) else {
            print("Core Data: Failed to delete vehicle")
            return
        }
        withAnimation {
            context.delete(items2[cdVehicleIndex])
            vehicles.removeAll(where: { $0.id == vehicleItem.id })
            do {
                try context.save()
            } catch {
                print("Core Data: Failed to save")
            }
        }
    }

    func printCoreDataStore() {
        print("Core Data: Here's what I have in the class list prior to fetching")
        items2.forEach { item1 in
            print("id: \(item1.id ?? UUID())")
            print("make: \(item1.make ?? "0")")
            print("model: \(item1.model ?? "0")")
        }
        print("Core Data: Fetching")
        items2 = CDVehicleItem.fetchCDVehicleItems()
        print("Core Data: Here's what I have in store")
        items2.forEach { item1 in
            print("id: \(item1.id ?? UUID())")
            print("make: \(item1.make ?? "0")")
            print("model: \(item1.model ?? "0")")
        }
    }

    func updateCDVehicleList() {
        items2 = CDVehicleItem.fetchCDVehicleItems()
    }
}
