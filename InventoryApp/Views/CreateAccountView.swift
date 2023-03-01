//
//  CreateAccountView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/11/23.
//

import SwiftUI

struct CreateAccountView: View {
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var passwordAgain = ""
    let labelFontSize: CGFloat = 14
    let rowBottomSpacing: CGFloat = 10
    let rowHorizontalSpacing: CGFloat = 20

    struct GenericTextView: View {
        @State var hint: String
        @Binding var userInput: String

        var body: some View {
            VStack {
                TextField(hint, text: $userInput)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                    .tint(darkThemePurple)
                    .textFieldStyle(.roundedBorder)
                    .font(Font.system(size: 14, design: .default))
                    .padding(.leading, 2)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .padding(.top, -5)
            }
            .padding(.bottom, 5)
        }
    }

    var body: some View {
            ZStack {
                BackgroundView()
                VStack {
                    LottieView(fileName: "bus")
                        .frame(width: 300, height: 150, alignment: .center)
                        .padding(.top, 70)
                        .padding(.bottom, 10)
                    // Row 1
                    HStack {
                        Text("Enter Email:")
                            .font(.system(size: labelFontSize))
                            .padding(.bottom, 9)
                            .padding(.trailing, 47)
                        GenericTextView(hint: "Email", userInput: $email)
                            .autocorrectionDisabled(false)
                    }
                    .padding(.horizontal, rowHorizontalSpacing)
                    .padding(.bottom, rowBottomSpacing)
                    // Row 2
                    HStack {
                        Text("Enter name:")
                            .font(.system(size: labelFontSize))
                            .padding(.bottom, 9)
                            .padding(.trailing, 47)
                        GenericTextView(hint: "Display Name", userInput: $name)
                            .autocorrectionDisabled(false)
                    }
                    .padding(.horizontal, rowHorizontalSpacing)
                    .padding(.bottom, rowBottomSpacing)
                    // Row 3
                    HStack {
                        Text("Enter Password:")
                            .font(.system(size: labelFontSize))
                            .padding(.bottom, 10)
                            .padding(.trailing, 20)
                        GenericTextView(hint: "Password", userInput: $password)
                            .autocorrectionDisabled(false)
                    }
                    .padding(.horizontal, rowHorizontalSpacing)
                    .padding(.bottom, rowBottomSpacing)
                    // Row 4
                    HStack {
                        Text("Enter Password:")
                            .font(.system(size: labelFontSize))
                            .padding(.bottom, 10)
                            .padding(.trailing, 20)
                        GenericTextView(hint: "Retype Password", userInput: $passwordAgain)
                            .autocorrectionDisabled(false)
                    }
                    .padding(.horizontal, rowHorizontalSpacing)
                    .padding(.bottom, rowBottomSpacing)
                    Spacer()
                    // Button
                    GenericButton(txt: "Create",
                                  action: createAccount)
                    .disabled(!isValidEmail(email) || name.count < 3 ||
                              password != passwordAgain || password.count < 4)
                    .padding(.vertical, 50)
                }
                .navigationTitle("Create Account")
            }
    }

    func createAccount() {
        if !Reachability.isConnectedToNetwork() {
            // TODO: Show popup
            print("Not connected to the internet")
            return
        }
        // do something
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
            CreateAccountView()
    }
}
