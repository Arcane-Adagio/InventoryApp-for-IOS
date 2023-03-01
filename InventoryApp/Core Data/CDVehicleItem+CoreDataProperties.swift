//
//  CDVehicleItem+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/23/23.
//
//

import CoreData
import Foundation

public extension CDVehicleItem {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CDVehicleItem> {
        return NSFetchRequest<CDVehicleItem>(entityName: "CDVehicleItem")
    }

    @NSManaged var mechNotes: String?
    @NSManaged var genNotes: String?
    @NSManaged var color: String?
    @NSManaged var tagExpiration: String?
    @NSManaged var vin: String?
    @NSManaged var model: String?
    @NSManaged var make: String?
    @NSManaged var year: Int64
    @NSManaged var id: UUID?
}

extension CDVehicleItem: Identifiable {
    //
}
