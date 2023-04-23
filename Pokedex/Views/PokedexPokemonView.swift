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
    https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1010
  
    Source code used from:
    https://www.youtube.com/watch?v=dmIot8Weoxg&ab_channel=Indently

 */

import SwiftUI
import SSSwiftUIGIFView
import SDWebImage

struct PokedexPokemonView: View {
    
    @State var pokemon = [PokemonEntry]()  // List of Pokemon in the view
    
    @State var searchText = ""
    var body: some View {
        
        NavigationView{
            
            
            List{
                // searchbar shows results
                // if the search bar is empty, display all other pokemon
                // otherwise, filter the pokemon with the letters typed
                ForEach(searchText == "" ? pokemon : pokemon.filter({
                    $0.name.contains(searchText.lowercased())
                })) { entry in
                   
                    VStack{
//                        Circle().frame(width: 100, height: 100).offset(x: 50, y: 10)
                        PokemonImage(imageLink: "\(entry.url)").position(x: 240, y: 60)
                        
                        NavigationLink("\(entry.name)".capitalized, destination: Text("Detail View for \(entry.name)".capitalized)).position(x: 150).font(.custom("GillSans", size: 20))
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
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex List")
            .toolbarBackground(Color.yellow.opacity(0.90), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            }.background(Color.black.ignoresSafeArea())
        
        }
    
    }

struct PokedexPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexPokemonView()
    }
}

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
