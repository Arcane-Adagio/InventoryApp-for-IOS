//
//  GenericTextView.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/12/23.
//

import SwiftUI

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

struct InputTextView: View {
    @State var hint: String
    @Binding var userInput: String
    @Binding var underlineColor: Color

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
                .foregroundColor(underlineColor)
                .padding(.top, -5)
        }
        .padding(.bottom, 5)
    }
}

struct InputPasswordView: View {
    @State var hint: String
    @Binding var userInput: String
    @Binding var underlineColor: Color

    var body: some View {
        VStack {
            SecureField(hint, text: $userInput)
                .textFieldStyle(.plain)
                .foregroundColor(.white)
                .tint(darkThemePurple)
                .textFieldStyle(.roundedBorder)
                .font(Font.system(size: 14, design: .default))
                .padding(.leading, 2)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(underlineColor)
                .padding(.top, -5)
        }
        .padding(.bottom, 5)
    }
}

struct GenericTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GenericTextView(hint: "Username", userInput: .constant(""))
            InputTextView(hint: "Email", userInput: .constant(""), underlineColor: .constant(Color.white))
            InputPasswordView(hint: "Password", userInput: .constant("asd"), underlineColor: .constant(Color.white))
        }
    }
}
