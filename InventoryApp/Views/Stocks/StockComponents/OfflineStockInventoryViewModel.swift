//
//  OfflineStockInventoryViewModel.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/30/23.
//

import Foundation

class OfflineStockInventoryViewModel: ObservableObject {
    static let singleton = OfflineStockInventoryViewModel()
    @Published var inventoryItems: [InventoryItem] = []
}
