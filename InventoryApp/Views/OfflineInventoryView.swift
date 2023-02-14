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

    var floatingActionButton: some View {
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

    var emptyInventoryView: some View {
        VStack {
            Spacer()
            ZStack {
                primaryDarkColor.opacity(0.3)
                    .frame(height: 100)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                Text("No Inventories to Show")
                    .shadow(radius: 3)
            }
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                HStack {
                    if items.isEmpty {
                        emptyInventoryView
                    } else {
                        List {
                            ForEach(items) { item in
                                let num: Int? = items.firstIndex(of: item)
                                NavigationLink {
                                    BackgroundView()
                                } label: {
                                    HStack {
                                        Text("Inventory #\(num!)")
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    .frame(height: 35)
                                }
                                // Draws a background stroke around each list item
                                .listRowBackground(
                                    EmptyView()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke()
                                        )
                                        .padding(
                                            EdgeInsets(
                                                top: 2,
                                                leading: 2,
                                                bottom: 2,
                                                trailing: 2
                                            )
                                        )
                                )
                                // Adjusts the position of the title and icon in the row
                                .listRowInsets(.init(top: 5, leading: 0, bottom: 10, trailing: 20))
                                // Does something important
                                .listRowSeparator(.hidden)
                                .listStyle(.plain)
                            }
                            // List modifier to allow swipe to delete
                            .onDelete(perform: deleteItems)
                        }
                        // Prevents List style from overriding background
                        .scrollContentBackground(.hidden)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        floatingActionButton
                    }
                }
            }
            .navigationTitle("Offline Inventories")
        }
        .tint(primaryLightColor)
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
