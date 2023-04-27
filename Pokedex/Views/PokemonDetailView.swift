//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Kinme on 4/23/23.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonEntry: PokemonEntry
    
    @State var pokemonSelected = PokemonSelected(sprites: PokemonSprites(), name: "", weight: 0, height: 0, species: Species(), types: [PokemonType]())
    // This doesn't get the currently active sprite
    @State var pokemonSpecies = PokemonSpecies(flavor_text_entries: [FlavorTextEntry]())
    @State var flavorText = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                VStack(alignment: .center){
                    Text(" POKEMON ENTRY ").background(Color.white).cornerRadius(5).padding(5).frame(width: 300, height: 50).font(.custom("GillSans", size: 28))
                        .bold()
                    
                   // Spacer()
                    
                }.fixedSize().background(Color.yellow.cornerRadius(10).frame(width: 360, height: 50).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)
                    
                ))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 6){
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6){
                        
                        Text(pokemonEntry.name.capitalized)
                       // Text("Type: " + pokemonSelected.)
                        Text("Height: " + String(round(Double(pokemonSelected.height) * 3.93701 )) + "\"")
                        Text("Weight: " + String(round(Double(pokemonSelected.weight) / 4.536)) + " lbs")
                    }.background(Color.white).cornerRadius(6).padding(5).frame(width: 300, height: 50)
                    
                    Spacer()
                }
                
                .font(.custom("GillSans", size: 25))
                .background(Color.yellow.cornerRadius(10).frame(width: 360, height: 150, alignment: .leading).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)
                ))
                
                .font(.custom("GillSans", size: 25))
                
                Spacer()
                
                VStack(alignment: .center){
                    //Divider()
                   // Spacer()
                    if (pokemonSelected.sprites.front_default != nil) {
//                        PokemonImage(imageLink: "\(pokemonSelected.sprites.front_default)")
                        
                        AsyncImage(url: URL(string: pokemonSelected.sprites.front_default!), scale: 0.30).frame(width: 200, height: 125).scaledToFit().padding()
                    }
                    
                    Spacer()
                    
                }
                
//                Spacer()

                HStack{
                   // Spacer()
                    
                    
                    HStack{
                        Text(self.flavorText).fixedSize(horizontal: false, vertical: true)
                    }.background(Color.white).cornerRadius(6).padding(.all).frame(width: 300, height: 50, alignment: .center)
                        .font(.custom("GillSans", size: 25))
                    
                  //  pokemonSpecies.flavor_text_entries[0].flavor_text
                    
                    //Spacer()
                }.background(Color.yellow.cornerRadius(10).frame(width: 360, height: 100).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)
                ))
                Spacer()
                Spacer()
            }.background(Image("Grid").opacity(0.10))
        }
        .onAppear{
            getData(url: pokemonEntry.url)
        }
    }
    
    func getData(url: String){
        PokemonSelectedApi().getData(url: url){ data in
            
            self.pokemonSelected = data
            let speciesUrl = data.species.url
//            self.types = data.types
            
            PokemonSpeciesApi().getData(url: speciesUrl){ speciesData in
                self.pokemonSpecies = speciesData
                self.flavorText = speciesData.flavor_text_entries[0].flavor_text
            }
        }
    }
}

//struct PokemonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetailView(pokemonEntry: PokemonEntry)
//    }
//}
