//
//  VehicleInventoryView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/28/23.
//

import SwiftUI

struct VehicleInventoryView: View {
    @ObservedObject var viewmodel = OfflineVehicleInventoryViewModel.singleton
    var sampleList = [VehicleItem(), VehicleItem(), VehicleItem(), VehicleItem(), VehicleItem(),
                      VehicleItem(), VehicleItem(), VehicleItem(), VehicleItem()]
    @State var fabIsOpen = false
    @State var editMode = false
    @State var showCreationSheet = false
    @State var keyboardIsShowing = false

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewmodel.vehicles) { vehicle in
                                VehicleItemCardView(vehicle, editMode)
                                    .padding(.vertical, 5)
//                                    .onTapGesture { // this breaks color picker
//                                        fabIsOpen = false
//                                    }
                            }
                        }
                    }
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Button {
                            showCreationSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 8, height: 8)
                                .foregroundColor(.white)
                                .padding()
                                .background(secondaryLightColor)
                                .clipShape(Circle())
                        }
                        .tint(secondaryLightColor)
                        .shadow(radius: 7)
                        .padding(.bottom, 5)
                        .disabled(!fabIsOpen)
                        .opacity(fabIsOpen ? 1 : 0)
                        Button {
                            editMode.toggle()
                        } label: {
                            Image(systemName: editMode ? "pencil.line" : "pencil.slash")
                                .frame(width: 8, height: 8)
                                .tint(.white)
                                .padding()
                                .background(secondaryLightColor)
                                .clipShape(Circle())
                        }
                        .frame(width: 50)
                        .padding(.bottom, 5)
                        .shadow(radius: 7)
                        .disabled(!fabIsOpen)
                        .opacity(fabIsOpen ? 1 : 0)
                        Button {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                fabIsOpen.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 25, height: 15)
                                .foregroundColor(.white)
                                .padding()
                                .background(secondaryLightColor)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(fabIsOpen ? 270 : 0))
                        }
                        .padding(.top, 5)
                        .tint(secondaryLightColor)
                        .shadow(radius: 5)
                        .disabled(keyboardIsShowing)
                        .opacity(keyboardIsShowing ? 0 : 1)
                    }
                    .padding(.bottom, 50)
                    .padding(.horizontal, 40)
                }
            }
//            .onTapGesture { // this breaks color picker
//                fabIsOpen = false
//            }
            .onReceive(keyboardPublisher) { value in
                keyboardIsShowing = value
                if value {
                    fabIsOpen = false
                }
            }
            .navigationTitle("Vehicles")
            .sheet(isPresented: $showCreationSheet) {
                VehicleCreationView(viewmodel.addVehicleItem(_:))
            }
        }
    }
}

struct VehicleInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleInventoryView()
    }
}
