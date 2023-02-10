//
//  InventoryAppApp.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/9/23.
//

import SwiftUI

@main
struct InventoryAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
