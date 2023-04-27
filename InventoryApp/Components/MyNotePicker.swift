//
//  MyNotePicker.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/26/23.
//

import SwiftUI

struct MyNotePicker: View {
    @Binding var date: NoteSection
    var sList = [NoteSection.general, NoteSection.mechanical]

    var body: some View {
        HStack {
            Spacer()
            Picker("", selection: $date) {
                ForEach(sList, id: \.self) {
                    Text($0.description)
                }
            }
            .tint(.white)
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

enum NoteSection {
    case general, mechanical

    var description: String {
      switch self {
      // Use Internationalization, as appropriate.
      case .general: return "General Notes"
      case .mechanical: return "Mechanical Notes"
      }
    }
}

struct MyNotePicker_Previews: PreviewProvider {
    static var previews: some View {
        MyNotePicker(date: .constant(.general))
    }
}
