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
    let labelFontSize: CGFloat = 14
    let rowBottomSpacing: CGFloat = 10
    let rowHorizontalSpacing: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {

                    LottieView(fileName: "welcome1")
                        .background(.clear)
                        .frame(width: 300, height: 150, alignment: .center)
                        .padding(.top, 15)
                        .padding(.bottom, 0)
                    Text("Login")
                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                        .padding(.bottom, 20)
                    // Row 1
                    HStack {
                        GenericTextView(hint: "Email", userInput: $email)
                            .autocorrectionDisabled(false)
                    }
                    .padding(.horizontal, rowHorizontalSpacing)
                    .padding(.bottom, rowBottomSpacing)
                    // Row 2
                    HStack {
                        GenericTextView(hint: "Password", userInput: $name)
                            .autocorrectionDisabled(false)
                    }
                    .padding(.horizontal, rowHorizontalSpacing)
                    //
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
                    Spacer()
                    // Button
                    GenericButton(txt: "Login",
                                  action: login)
                    Spacer()
                    // Create Account
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
    
    func login() {
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
