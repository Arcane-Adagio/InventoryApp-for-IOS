//
//  CDInventoryItem+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/14/23.
//
//

import CoreData
import Foundation

extension CDInventoryItem {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CDInventoryItem> {
        return NSFetchRequest<CDInventoryItem>(entityName: "CDInventoryItem")
    }

    @NSManaged public var checked: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var quantity: Double
}

extension CDInventoryItem: Identifiable {
    //
}
