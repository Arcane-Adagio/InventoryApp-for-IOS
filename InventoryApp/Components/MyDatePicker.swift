//
//  MyDatePicker.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/26/23.
//

import SwiftUI

struct MyDatePicker: View {
    let label: String
    @Binding var date: Date
    let action: (Date) -> Void
    var body: some View {
        DatePicker(label, selection: $date, displayedComponents: [.date])
            .datePickerStyle(CompactDatePickerStyle())
            .onChange(of: date, perform: action)
    }
}

struct MyDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MyDatePicker(label: "picker", date: .constant(Date())) { _ in
            //
        }
    }
}
