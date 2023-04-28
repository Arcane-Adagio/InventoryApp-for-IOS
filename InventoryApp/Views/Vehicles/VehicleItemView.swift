//
//  VehicleItemView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/19/23.
//

import SwiftUI

struct VehicleItemView: View {
    @ObservedObject var vehicle: VehicleItem
    @State var showDetailSheet = false
    var moreInfo: () -> Void
    var saveToCoreData: (VehicleItem) -> Void

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(vehicle.year + " " + vehicle.make + " " + vehicle.model)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .padding(.top, 10)
                        .padding(.bottom, -5)
                    Text("Tag expires on \(vehicle.tagExp)")
                        .font(.system(size: 10, weight: .light, design: .rounded))
                        .padding(.bottom, 10)
                }
                .padding(.horizontal)
                Spacer()
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(.trailing, 15)
                    .padding(.leading, 10)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showDetailSheet.toggle()
                    }
            }
        }
        .fullScreenCover(isPresented: $showDetailSheet) {
            VehicleDetailView(vehicle: vehicle, saveFunc: saveToCoreData)
        }
    }
}

struct VehicleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            VehicleItemView(vehicle: VehicleItem(), moreInfo: {}) { _ in 
                // 
            }
        }
    }
}
