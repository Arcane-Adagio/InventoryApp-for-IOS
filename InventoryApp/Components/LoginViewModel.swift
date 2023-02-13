//
//  LoginViewModel.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/12/23.
//

import Foundation
import SwiftUI

final class LoginViewModel {
    static let shared = LoginViewModel()

    func checkConnection() -> Bool {
        // if connection return true
        return true
        // else return false
    }

    func login() -> Bool {
        // if authentication failure, return false
        // else Perform login
        return true
    }
}
