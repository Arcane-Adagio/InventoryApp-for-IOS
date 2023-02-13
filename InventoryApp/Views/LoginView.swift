//
//  LoginView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/12/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var passwordAgain = ""
    @State var textViewColor = Color.white
    let labelFontSize: CGFloat = 14
    let rowBottomSpacing: CGFloat = 10
    let rowHorizontalSpacing: CGFloat = 20
    var viewModel = LoginViewModel.shared
    var isValid: Bool {
        if !email.isEmpty && !password.isEmpty
            && email.count > 3 && password.count > 3 {
            return true
        } else {
            return false
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    // Animation
                    LottieView(fileName: "welcome1")
                        .background(.clear)
                        .frame(width: 300, height: 150, alignment: .center)
                        .padding(.top, 15)
                        .padding(.bottom, 0)
                    // Title
                    Text("Login")
                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                        .padding(.bottom, 20)
                    // Email
                    InputTextView(hint: "Email", userInput: $email, underlineColor: $textViewColor)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(false)
                        .padding(.horizontal, rowHorizontalSpacing)
                        .padding(.bottom, rowBottomSpacing)
                    // Password
                    InputPasswordView(hint: "Password", userInput: $password, underlineColor: $textViewColor)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(false)
                        .padding(.horizontal, rowHorizontalSpacing)
                    // Forgot Password
                    HStack {
                        NavigationLink {
                            ForgotPasswordView()
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, rowHorizontalSpacing)
                        Spacer()
                    }
                    // Empty Space
                    Spacer()
                    // Login Button
                        Button {
                            if Reachability.isConnectedToNetwork() {
                                login()
                            } else {
                                // TODO: Show popup
                                print("Not connected to the internet")
                            }
                        } label: {
                            Text("Login")
                                .foregroundColor(isValid
                                                  ? .white : .white.opacity(0.6))
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke()
                                )
                                .background(secondaryLightColor)
                        }
                        .cornerRadius(7)
                        .tint(secondaryLightColor)
                        .shadow(radius: 4)
                        .disabled(!isValid)
                    // Empty Space
                    Spacer()
                    // Bottom Text
                    HStack {
                        Text("Don't have an account?")
                        NavigationLink {
                            CreateAccountView()
                        } label: {
                            Text("Create Account")
                                .foregroundColor(.purple)
                        }
                    }
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.vertical, 30)
                }
            }
        }
        .tint(primaryLightColor)
    }

    private func badAuthenicationBehavior() {
        // Make underlines red
        textViewColor = Color.red
        // Clear text fields
        email = ""
        password = ""
    }

    func login() {
        if viewModel.checkConnection() {
            if viewModel.login() {
                // navigate to online view
            } else {
                // show authentication failure pop-up
                // or this
                badAuthenicationBehavior()
            }
        } else {
            // show no internet pop-up
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
