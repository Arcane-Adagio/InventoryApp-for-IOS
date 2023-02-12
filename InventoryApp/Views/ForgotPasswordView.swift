//
//  ForgotPasswordView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/12/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = ""
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                // Panda
                LottieView(fileName: "panda")
                    .background(.clear)
                    .frame(width: 300, height: 150, alignment: .center)
                    .padding(.top, 60)
                    .padding(.bottom, 0)
                // Email Address View
                VStack {
                    HStack {
                        Text("Please enter your email address: ")
                            .font(.system(size: 14, weight: .light, design: .default))
                        Spacer()
                    }
                    GenericTextView(hint: "Email", userInput: $email)
                        .autocorrectionDisabled(false)
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .padding(.bottom, 20)
                // Space
                Spacer()
                // Button
                GenericButton(txt: "Send Reset Email", action: resetPassword)
                    .padding(.bottom, 90)
            }
        }
        .navigationTitle("Reset Password")
    }
    
    func resetPassword() {
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
