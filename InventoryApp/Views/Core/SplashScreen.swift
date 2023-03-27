//
//  SplashScreen.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 3/27/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var circleMovement = true
    @State var iconImage = true
    @State var cornerRadi = true
    @State var splashing = true
    let backgroundGradient = LinearGradient(gradient: Gradient(colors:
                                                                [Color(hex: "7550bc"), Color(hex: "1c067d")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing)

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            LottieView(fileName: "9601-sound-wave-motion")
                .frame(width: 200, height: 200)
            RoundedRectangle(cornerRadius: cornerRadi ? 500 : 10)
                .fill(Color.black)
                .scaleEffect(circleMovement ? 3 : 0.1)
                .frame(height: 420)
            Image(systemName: "square.and.pencil.circle")
                .resizable()
                .frame(width: iconImage ? 40 : 100,
                       height: iconImage ? 40 : 100)
        }
        .opacity( splashing ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                circleMovement.toggle()
                iconImage.toggle()
                cornerRadi.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeIn(duration: 1.0)) {
                    splashing.toggle()
                }
            }
        }
    }

    func closeCircle() {
        //
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
