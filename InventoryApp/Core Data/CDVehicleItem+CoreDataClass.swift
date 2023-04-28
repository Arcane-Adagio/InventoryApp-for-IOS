//
//  CDVehicleItem+CoreDataClass.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/23/23.
//
//

import CoreData
import Foundation

public class CDVehicleItem: NSManagedObject {
    @nonobjc
    internal func toVehicleItem() -> VehicleItem {
        return VehicleItem(
            year: String(year),
            make: make ?? "",
            model: model ?? "",
            vin: vin ?? "",
            id: id ?? UUID(),
            tagExp: tagExpiration ?? "",
            color: color ?? "[0,0,0,0]",
            genNotes: genNotes ?? "",
            mechNotes: mechNotes ?? ""
        )
    }

    @nonobjc
    class func fetchVehicleItems() -> [VehicleItem] {
        let request: NSFetchRequest<CDVehicleItem> = NSFetchRequest<CDVehicleItem>(entityName: "CDVehicleItem")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        var cdVehicleItems: [CDVehicleItem]
        do {
            cdVehicleItems = try PersistenceController.shared.viewContext.fetch(request)
        } catch {
            cdVehicleItems = []
        }

        if !cdVehicleItems.isEmpty {
            var vehicleArray: [VehicleItem] = []
            for cdVehicleItem in cdVehicleItems {
                vehicleArray.append(cdVehicleItem.toVehicleItem())
            }
            return vehicleArray
        } else {
            return []
        }
    }

    @nonobjc
    class func fetchCDVehicleItems() -> [CDVehicleItem] {
        let request: NSFetchRequest<CDVehicleItem> = NSFetchRequest<CDVehicleItem>(entityName: "CDVehicleItem")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        var cdVehicleItems: [CDVehicleItem]
        do {
            cdVehicleItems = try PersistenceController.shared.viewContext.fetch(request)
        } catch {
            cdVehicleItems = []
        }

        if !cdVehicleItems.isEmpty {
            var vehicleArray: [CDVehicleItem] = []
            for cdVehicleItem in cdVehicleItems {
                vehicleArray.append(cdVehicleItem)
            }
            return vehicleArray
        } else {
            return []
        }
    }

    @nonobjc
    internal func assignVehicleItem(_ vehicleItem: VehicleItem) {
        self.color = vehicleItem.color
        self.year = Int64(Int(vehicleItem.year) ?? 0)
        self.make = vehicleItem.make
        self.model = vehicleItem.model
        self.vin = vehicleItem.vin
        self.id = vehicleItem.id
        self.tagExpiration = vehicleItem.tagExp
        self.genNotes = vehicleItem.genNotes
        self.mechNotes = vehicleItem.mechNotes
    }

    @nonobjc
    class func deleteCDVehicleItemById(id: UUID) -> Bool {
        let cdVehicleItems = CDVehicleItem.fetchCDVehicleItemById(id: id)
        if cdVehicleItems.isEmpty {
            return true
        } else {
            for items in cdVehicleItems {
                PersistenceController.shared.viewContext.delete(items)
            }
        }

        do {
            try PersistenceController.shared.viewContext.save()
            return true
        } catch {
            return false
        }
    }

    @nonobjc
    class func addVehicleItem(_ vehicleItem: VehicleItem) {
        let item = CDVehicleItem(context: PersistenceController.shared.viewContext)
        item.assignVehicleItem(vehicleItem)
        do {
            try PersistenceController.shared.viewContext.save()
        } catch {
            print("debug: no")
        }
    }

    @nonobjc
    class func fetchCDVehicleItemById(id: UUID) -> [CDVehicleItem] {
        let request: NSFetchRequest<CDVehicleItem> = NSFetchRequest<CDVehicleItem>(entityName: "CDVehicleItem")
        request.predicate = NSPredicate(
            format: "id = %i", id as NSUUID
        )
        var cdVehicleItem: [CDVehicleItem]
        do {
            cdVehicleItem = try PersistenceController.shared.viewContext.fetch(request)
        } catch {
            cdVehicleItem = []
        }
        return cdVehicleItem
    }

    class func clearData() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "CDVehicleItem"))

        DispatchQueue.main.async {
            do {
                try PersistenceController.shared.viewContext.execute(deleteRequest)
            } catch let error as NSError {
                print("Error clearing Core Data Store for FCI: ", error)
            }
        }
    }

    static func == (lhs: CDVehicleItem, rhs: CDVehicleItem) -> Bool {
        return lhs.id == rhs.id
    }
}
