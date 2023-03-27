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
    @State var showingSplash = true

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
            if showingSplash {
                SplashScreen()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.easeOut(duration: 5)) {
                    showingSplash = false
                }
            }
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
