//
//  InventoryItem.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/19/23.
//

import Foundation
import SwiftUI

class InventoryItem: ObservableObject, Identifiable {
    @Published var id: UUID
    @Published var checked: Bool
    @Published var name: String
    @Published var quantityRS: String
    @Published var quantityOH: String
    @Published var date: Date
    @Published var note: String
    @Published var checkable: Bool
    @Published var auditLog: [String]
    @Published var brand: String

    init(checked: Bool = false, name: String = "Sample Item",
         quantityOH: String = "5", quantityRS: String = "10", date: Date = Date(),
         note: String = "The fitness gram pacer test is...",
         checkable: Bool = false, auditLog: [String] = [], id: UUID = UUID(),
         brand: String = "") {
        self.checked = checked
        self.name = name
        self.quantityOH = quantityOH
        self.quantityRS = quantityRS
        self.date = date
        self.note = note
        self.checkable = checkable
        self.auditLog = auditLog
        self.id = id
        self.brand = brand
    }

    // For nil coalescing
    init() {
        self.checked = false
        self.name = ""
        self.quantityOH = ""
        self.quantityRS = ""
        self.date = Date()
        self.note = "The fitness gram pacer test is..."
        self.checkable = false
        self.auditLog = []
        self.id = UUID()
        self.brand = ""
    }
}

extension InventoryItem: Equatable {
    static func == (lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        return lhs.id == rhs.id
    }
}
