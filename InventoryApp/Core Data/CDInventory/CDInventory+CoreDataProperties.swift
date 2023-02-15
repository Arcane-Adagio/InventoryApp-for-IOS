//
//  CDInventory+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/14/23.
//
//

import CoreData
import Foundation

extension CDInventory {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CDInventory> {
        return NSFetchRequest<CDInventory>(entityName: "CDInventory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var items: [CDInventoryItem]?
    @NSManaged public var name: String?
}

extension CDInventory: Identifiable {
    //
}
