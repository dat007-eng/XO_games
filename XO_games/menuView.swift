//
//  menuView.swift
//  XO_games
//
//  Created by dat on 29/08/2022.
//

import SwiftUI

struct menuView: View {
    var body: some View {
        NavigationView{
            NavigationLink("Play",destination: ContentView())
        
        }
            }
}

struct menuView_Previews: PreviewProvider {
    static var previews: some View {
        menuView()
    }
}
