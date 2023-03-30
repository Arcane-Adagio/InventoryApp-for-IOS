//
//  ContentView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/9/23.
//

import CoreData
import SwiftUI
import UIKit

struct ContentView: View {
    @State var showMoreOptions = false
    @State var showingSplash = true
    @State var viewIsShowing = false

    init() {
        UITextView.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }

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
                    .onAppear {
                        viewIsShowing.toggle()
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
        .alert("Coming Soon", isPresented: $viewIsShowing, actions: {})
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
