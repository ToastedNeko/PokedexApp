//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Kinme on 4/22/23.
//

/*
    This displays the detials for each Pokemon pokedex
    entry
 */

import SwiftUI

struct PokemonDetailsView: View {
    var body: some View {
        NavigationView{
            
            Text("This will contain details for each Pokemon")
                //.font(Font.custom("PokemonGB", size: 12))
                .font(.custom("GillSans", size: 20))
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView()
    }
}
