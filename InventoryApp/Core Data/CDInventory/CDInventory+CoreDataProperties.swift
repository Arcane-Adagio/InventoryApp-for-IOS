//
//  CDInventory+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/14/23.
//
//

import CoreData
import Foundation

public extension CDInventory {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CDInventory> {
        return NSFetchRequest<CDInventory>(entityName: "CDInventory")
    }

    @NSManaged var id: UUID?
    @NSManaged var items: [CDInventoryItem]?
    @NSManaged var name: String?
}

extension CDInventory: Identifiable {
    //
}
