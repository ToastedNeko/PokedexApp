//
//  ContentView.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.
//
/*
    This displays all of the Pokemon entries available in
    the Pokedex
 */

import SwiftUI
import SSSwiftUIGIFView
import SDWebImage

struct PokedexPokemonView: View {
    var body: some View {
        
        NavigationView{
                Text("Content")
                    .bold()
                    .onAppear{
                        // print the values of each pokemon for testing purposes
                        PokemonApi().getData(){ pokemon in
                            print(pokemon)
                            for pokemon in pokemon{
                                print(pokemon.name)
                                //print(pokemon.)
                            }
                        }
                    }
            }.background(Color.black.ignoresSafeArea())
        }
    }

struct PokedexPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexPokemonView()
    }
}
