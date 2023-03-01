//
//  Extensions.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/28/23.
//

import Foundation
import SwiftUI

/** This binding makes it so that a textfield can have a max length*/
extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
