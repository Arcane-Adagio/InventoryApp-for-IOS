//
//  Stack.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/19/23.
//

import Foundation

struct Stack<T>: CustomStringConvertible {
    // array of items
    var items: [T] = []

    // to print the formatted description
    var description: String {
        return "---- Stack begin ----\n" +
        items.map({ "\($0)" }).joined(separator: "\n") +
        "\n---- Stack End ----"
    }

    mutating func push(_ item: T) {
        self.items.insert(item, at: 0)
    }

    @discardableResult
    mutating func pop() -> T? {
        if items.isEmpty { return nil }
        return self.items.removeFirst()
    }

    func peek() -> T? {
        return self.items.first
    }
}
