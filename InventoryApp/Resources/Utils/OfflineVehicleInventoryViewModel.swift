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
            print("here's what's in storage: \(items2.map { $0.id })")
            return
        }
        items2[cdVehicleIndex].assignVehicleItem(modVehicle)
        do {
            try context.save()
        } catch {
            print("debug: no")
        }
    }

    func addItem(context: NSManagedObjectContext) {
        withAnimation {
            let newItem = CDInventory(context: context)
            newItem.name = "placerholder"
            newItem.id = UUID()

            do {
                try context.save()
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

    func deleteVehicleItem(offsets: IndexSet, context: NSManagedObjectContext) {
        withAnimation {
            for index in offsets {
                context.delete(items2[index])
                vehicles.remove(at: index)
                try? context.save()
            }
        }
    }
}
