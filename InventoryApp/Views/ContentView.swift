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
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarLeading) {
        //                    Text("Offline Inventories").font(.headline)
        //                }
        //                ToolbarItem {
        //                    Button(action: showOptions) {
        //                        Image(systemName: "ellipsis")
        //                            .rotationEffect(Angle(degrees: 90))
        //                            .foregroundColor(Color.white)
        //                            .shadow(radius: 1)
        //                            .overlay(showMoreOptions ? optionsOverlay: nil)
        //                    }
        //                }
        //            }
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
