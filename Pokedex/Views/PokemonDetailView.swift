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
            VStack{
                Spacer()
                VStack{
                    Spacer()
                    Text(" POKEMON ENTRY ").background(Color.white).cornerRadius(5).padding(5).frame(width: 300, height: 50).font(.custom("GillSans", size: 28))
                        .bold()
                    Spacer()
                }.fixedSize().background(Color.yellow.cornerRadius(10).frame(width: 360, height: 50).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)
                    
                ))
            
                VStack{
                    Spacer().frame(height: 75)
                    VStack{
                        Spacer()
                        Text(pokemonEntry.name.capitalized)
                        Text("Height: " + String(round(Double(pokemonSelected.height) * 3.93701 )) + "\"")
                        Text("Weight: " + String(round(Double(pokemonSelected.weight) / 4.536)) + " lbs")
                       
                    }.background(Color.white).cornerRadius(6).padding(5).frame(width: 300, height: 50)
                    Spacer().frame(height: 75)
                }
                
                .font(.custom("GillSans", size: 25))
                .background(Color.yellow.cornerRadius(10).frame(width: 360, height: 150, alignment: .leading).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)

                ))
                //Spacer()
               
                VStack{
                    Spacer().frame(height: 15)
                    if (pokemonSelected.sprites.front_default != nil) {
                        AsyncImage(url: URL(string: pokemonSelected.sprites.front_default!), scale: 0.30).frame(width: 200, height: 125).scaledToFit().padding()
                    }
                    Spacer()
                }
                
                                HStack{
                                   Spacer()


                                    HStack{
                                        Text(self.flavorText).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                        Spacer()
                                    }.background(Color.white).cornerRadius(6).padding(.all).frame(width: 350, height: 50, alignment: .leading)
                                        .font(.custom("GillSans", size: 25))

                                    Spacer()
                                }.background(Color.yellow.cornerRadius(10).frame(width: 360, height: 250, alignment: .leading).shadow(radius: 20).scaledToFit().overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 5)
                                ))
               //Spacer()


               //
            }.background(Image("Grid").opacity(0.10))
            
            //Spacer().frame(height: 50)
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
