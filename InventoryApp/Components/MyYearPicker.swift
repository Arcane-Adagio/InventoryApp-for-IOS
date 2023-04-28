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
    let currentYear = (Int(DateFormatter.getYear.string(from: Date())) ?? 2_099) + 1

    var body: some View {
        HStack {
            Text(label)

            Spacer()
            Picker("", selection: $date) {
                ForEach(1_980...currentYear, id: \.self) {
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
