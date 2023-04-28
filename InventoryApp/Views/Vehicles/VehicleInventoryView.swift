//
//  VehicleInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/28/23.
//

import SwiftUI

struct VehicleInventoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var showCreationSheet = false
    @State var showDetailSheet = false
    let debugMode = false
    @StateObject var inventoryVM = OfflineVehicleInventoryViewModel.singleton

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

    func detailView() {
        showDetailSheet.toggle()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                HStack {
                    if !inventoryVM.vehicles.isEmpty {
                        List {
                            ForEach(inventoryVM.vehicles) { vehicle in
                                VehicleItemView(vehicle: vehicle,
                                                moreInfo: detailView)
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
                            .onDelete { indiceSet in
                                inventoryVM.deleteVehicleItem(offsets: indiceSet, context: viewContext)
                            }
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
            .navigationTitle("Vehicles")
        }
        .tint(primaryLightColor)
        .sheet(isPresented: $showCreationSheet) {
            VehicleCreationView(inventoryVM.addVehicleItem(_:))
        }
    }

    var floatingActionButton: some View {
        Button {
            if debugMode {
                inventoryVM.addVehicleItem()
            } else {
                showCreationSheet.toggle()
            }
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

struct VehicleInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleInventoryView()
    }
}
