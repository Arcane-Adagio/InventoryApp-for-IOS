//
//  CDInventoryItem+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/14/23.
//
//

import CoreData
import Foundation

public extension CDInventoryItem {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CDInventoryItem> {
        return NSFetchRequest<CDInventoryItem>(entityName: "CDInventoryItem")
    }

    @NSManaged var checked: Bool
    @NSManaged var date: Date?
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var quantity: Double
}

extension CDInventoryItem: Identifiable {
    //
}
