//
//  ContentView.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.
//
/*
 This displays all of the Pokemon entries available in
 the Pokedex
 
 
 Contains all Pokemon currently available with its
 name and url containing the data:
 https://pokeapi.co/api/v2/pokemon/?offset=0&limit=251
 
 Source code used from:
 https://www.youtube.com/watch?v=dmIot8Weoxg&ab_channel=Indently
 
 */

import SwiftUI
import SSSwiftUIGIFView
import SDWebImage
import Foundation

struct PokedexPokemonView: View {
    
    @State var pokemon = [PokemonEntry]() // List of Pokemon in the view
    @State var searchText = ""
    @EnvironmentObject var capturedPokemon: CapturedPokemon
    //var pokemonEntry: PokemonEntry
    
    var body: some View {
        NavigationView{
            
            List{
                // searchbar shows results
                // if the search bar is empty, display all other pokemon
                // otherwise, filter the pokemon with the letters typed
                ForEach(searchText == "" ? pokemon : pokemon.filter({
                    $0.name.contains(searchText.lowercased())
                    
                })) { entry in
                    
                    HStack{
                        
                        // Default image is a grayscale, low opacity pokeball to signify the user doesn't yet own this Pokemon
                        //
                        
                        if(capturedPokemon.isPokemonCaptured(pokemonName: entry.name)){
                            Image("Pokeball1").padding(EdgeInsets(top: 1, leading: -6, bottom: 1, trailing: 4))
                        }else{
                            Image("GrayPokeball1").opacity(0.4).padding(EdgeInsets(top: 1, leading: -6, bottom: 1, trailing: 4))
                        }
                        
                        NavigationLink("\(entry.name)".capitalized, destination: PokemonDetailView(pokemonEntry: entry)
                            .environmentObject(capturedPokemon))
                        
                        PokemonImage(imageLink: "\(entry.url)")
                        
                        Spacer()
                        
                    }
                }
            }
            .onAppear{
                // call the completion listener
                // once completion is retreived, return it and assign to
                // new array
                PokemonApi().getData(){ pokemon in
                    self.pokemon = pokemon
                    
                }
                capturedPokemon.loadCapturedPokemon()
            }
            .searchable(text: $searchText)
            .navigationTitle("POKEDEX LIST")
            .toolbarBackground(Color.yellow.opacity(0.90), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        }.background(Color.black.ignoresSafeArea())
            .font(.custom("GillSans", size: 23))
        
    }
    
}

//struct PokedexPokemonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokedexPokemonView()
//    }
//}

// Testing Code
//    .onAppear{
// print the values of each pokemon for testing purposes
//                        PokemonApi().getData(){ pokemon in
//                            print(pokemon)
//                            for pokemon in pokemon{
//                                print(pokemon.name)
//                                //print(pokemon.)
//                            }
//                        }

// Testing purposes for image api data
//        PokemonSelectedApi().getData(url: "https://pokeapi.co/api/v2/pokemon/6/"){ url in
//            print(url)
//        }
//    }


// iterate through the the entire list of Pokemon
//                    for pokemon in pokemon{
//                        print(pokemon.name)
//                    }
