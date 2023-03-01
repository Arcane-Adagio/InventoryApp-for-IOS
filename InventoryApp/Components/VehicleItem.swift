//
//  VehicleItem.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/19/23.
//

import Foundation
import SwiftUI

class VehicleItem: ObservableObject, Identifiable {
    var id: UUID
    @Published var year: String
    @Published var make: String
    @Published var model: String
    @Published var vin: String
    @Published var tagExp: String
    @Published var color: String
    @Published var genNotes: String
    @Published var mechNotes: String

    init(year: String = "2077", make: String = "Ferrari",
         model: String = "Pilot", vin: String = "SPEEDDELABAMALAND", id: UUID = UUID(),
         tagExp: String = "03/78", color: String = "Ruby Red",
         genNotes: String = "This thing is fast",
         mechNotes: String = "Needs oil change") {
        self.year = year
        self.make = make
        self.model = model
        self.vin = vin
        self.tagExp = tagExp
        self.color = color
        self.genNotes = genNotes
        self.mechNotes = mechNotes
        self.id = id
    }

    // For nil coalescing
    init() {
        self.year = "2077"
        self.make = "Ferrari"
        self.model = "Pilot"
        self.vin = "SPEEDDELABAMALAND"
        self.tagExp = "03/78"
        self.color = "Ruby Red"
        self.genNotes = "This thing is fast"
        self.mechNotes = "Needs oil change"
        self.id = UUID()
    }
}

extension VehicleItem: Equatable {
    static func == (lhs: VehicleItem, rhs: VehicleItem) -> Bool {
        return lhs.id == rhs.id
    }
}
