//
//  MyYearPicker.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/26/23.
//

import SwiftUI

struct MyYearPicker: View {
    let label: String
    @Binding var date: Int

    var body: some View {
        HStack {
            Text(label)

            Spacer()
            Picker("", selection: $date) {
                ForEach(1_980...2_100, id: \.self) {
                    Text(String($0))
                }
            }
            .tint(.white)
        }
    }
}

struct MyYearPicker_Previews: PreviewProvider {
    static var previews: some View {
        MyYearPicker(label: "Year Picker", date: .constant(2_002))
    }
}
