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
    @State var pokemonDataLoaded = false
    
    var body: some View {
        NavigationView{
            List{
                
                // searchbar shows results
                // if the search bar is empty, display all other pokemon
                // otherwise, filter the pokemon with the letters typed
                
                // pokemon.enumerated() allows for index of Pokemon to be retrieved
                // each Pokemon has their own entry number in the Pokedex
                ForEach(Array(pokemon.enumerated()), id: \.1.id) { index, entry in
                    HStack{
                        
                        // Default image is a grayscale, low opacity pokeball to signify the user doesn't yet own this Pokemon
                        if(capturedPokemon.isPokemonCaptured(pokemonName: entry.name)){
                            Image("Pokeball1")
                                .padding(EdgeInsets(top: 1, leading: -10, bottom: 1, trailing: 6))
                        }else{
                            Image("GrayPokeball1")
                                .opacity(0.4)
                                .padding(EdgeInsets(top: 1, leading: -10, bottom: 1, trailing: 6))
                        }
                        
                        Text(" #\(index + 1)")
                            .padding(.trailing, 2).bold()
                        
                        NavigationLink(
                            destination: PokemonDetailView(pokemonEntry: entry)
                                .environmentObject(capturedPokemon)
                                .onAppear {
                                    capturedPokemon.currentPokemonIndex = index + 1
                                },
                            label: {
                                Text("\(entry.name)".capitalized)
                            }
                        )
                        
                        PokemonImage(imageLink: "\(entry.url)")
                        
                        Spacer()
                        
                    }
                    
                    .padding(.vertical, 5)
                }
            }
            
            .onAppear{
                // call the completion listener
                // once completion is retreived, return it and assign to
                // new array
                
                // check if data is already loaded so that it doesn't need to be reloaded
                // each time the navigation link is used between PokedexPokemonView and
                // PokemonDetailView
                if !pokemonDataLoaded {
                    PokemonApi().getData { pokemon in
                        self.pokemon = pokemon
                        pokemonDataLoaded = true
                    }
                    capturedPokemon.loadCapturedPokemon()
                }
            }
            .searchable(text: $searchText) // TODO - not currently working with new number implementation
            .navigationTitle("POKEDEX LIST")
            .toolbarBackground(Color.yellow.opacity(0.90), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        }.background(Color.black.ignoresSafeArea())
            .font(.custom("GillSans", size: 22))
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
