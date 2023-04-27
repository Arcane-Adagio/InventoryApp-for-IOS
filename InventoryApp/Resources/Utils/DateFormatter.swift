//
//  DateFormatter.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 4/26/23.
//

import Foundation

extension DateFormatter {
    static var formate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter
    }
}

func textfieldModi(_ tType: TextFieldType, _ text: String) -> String {
    switch tType {
    default:
        return validDateText(text)
    }

    func validDateText(_ text: String) -> String {
        if text.count == 3 && !text.contains("/") {
            var mText2 = text
            mText2.insert("/", at: String.Index(encodedOffset: 2))
            return mText2
        } else if text.count > 5 {
            // TODO: insert logic to limit size
            return text
        } else {
            return text
        }
    }
}
