//
//  XOButton.swift
//  XO_games
//
//  Created by dat on 29/08/2022.
//

import SwiftUI

struct XOButton: View {
    @Binding var character: String
    @State private var point = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(.gray)
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("RectangleColor"))
            Text(character)
                .font(.system(size: 50))
                .bold()
        }
        .rotation3DEffect(.degrees(point), axis: (x: 1, y: 0, z: 0))
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    withAnimation(.easeIn(duration: 0.25)) {
                        self.point -= 180
                    }
                }
        )
    }
}


struct XOButton_Previews: PreviewProvider {
    static var previews: some View {
        XOButton(character: .constant("X"))
    }
}
