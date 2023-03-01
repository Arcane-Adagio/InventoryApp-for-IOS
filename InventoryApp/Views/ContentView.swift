//
//  ContentView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/9/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @State var showMoreOptions = false

    var body: some View {
        ZStack {
            BackgroundView()
            TabView {
                OfflineInventoryView()
                    .tabItem {
                        Image(systemName: "wifi.slash")
                        Text("Offline")
                    }
                LoginView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Online")
                    }
            }
            .tint(.purple)
        }
    }

    func showOptions() {
        showMoreOptions.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
