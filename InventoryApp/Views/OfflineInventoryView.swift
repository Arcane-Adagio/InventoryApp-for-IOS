//
//  OfflineInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/13/23.
//

import Foundation
import SwiftUI

struct OfflineInventoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)

    private var items: FetchedResults<Item>

    var body: some View {
        ZStack {
            BackgroundView()
            HStack {
                if items.isEmpty {
                    Text("Add an Inventory")
                } else {
                    List {
                        ForEach(items) { item in
                            let num = items.firstIndex(of: item)
                            NavigationLink {
                                Image(systemName: "plus")
                            } label: {
                                Text("Inventory #\(num!)")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        addItem()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(secondaryLightColor)
                            .clipShape(Circle())
                    }
                    .tint(secondaryLightColor)
                    .shadow(radius: 3)
                    .padding(.vertical, 50)
                    .padding(.horizontal, 40)
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct OfflineInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineInventoryView()
    }
}
