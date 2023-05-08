//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Kinme on 4/23/23.
//
// 


import SwiftUI

struct PokemonDetailView: View {
    var pokemonEntry: PokemonEntry
    
    @State var pokemonSelected = PokemonSelected(sprites: PokemonSprites(), name: "", weight: 0, height: 0, species: Species(), types: [PokemonType]())
    @State var pokemonSpecies = PokemonSpecies(flavor_text_entries: [FlavorTextEntry]())
    @State var flavorText = ""
    
    var body: some View {
        ScrollView{
            LazyVStack{
                VStack{
                    Spacer().frame(height: 5)
                    Text(" POKEMON ENTRY ").background(Color.white).cornerRadius(5).padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)).font(.custom("GillSans", size: 28))
                        .bold()
                    Spacer().frame(height: 5)
                }.fixedSize().cornerRadius(10).padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30)).background(.yellow).overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)
                ).shadow(radius: 5)
                Spacer().frame(height: 25)
                VStack{
                    Spacer().frame(height: 10)
                    VStack(spacing: 6){

                        Text(pokemonEntry.name.capitalized)
                        Text("Height: " + String(round(Double(pokemonSelected.height) * 3.93701 )) + "\"")
                        Text("Weight: " + String(round(Double(pokemonSelected.weight) / 4.536)) + " lbs")
                       
                    }.fixedSize(horizontal: false, vertical: true).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)).multilineTextAlignment(.leading).background(Color.white).cornerRadius(6)
                    Spacer().frame(height: 5)
                }
                
                .font(.custom("GillSans", size: 25))
                .cornerRadius(10).padding(EdgeInsets(top: 5, leading: 100, bottom: 5, trailing: 100)).background(.yellow).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 5)

                ).shadow(radius: 20)
               
                VStack{
                    
                    
                    Spacer().frame(height: 1)
                    if (pokemonSelected.sprites.front_default != nil) {
                        
                        AsyncImage(url: URL(string: pokemonSelected.sprites.front_default!), scale: 0.40).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                    }
                    Spacer().frame(height: 1)
                }
                
                VStack(alignment: .leading, spacing: 6){

                                    HStack{
                                        Text(self.flavorText).fixedSize(horizontal: false, vertical: true).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)).multilineTextAlignment(.leading)
                                        
                                    }.cornerRadius(6).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)).background(Color.white)
                                        .font(.custom("GillSans", size: 25))

                }.cornerRadius(10).padding(EdgeInsets(top: 10, leading: 80, bottom: 10, trailing: 80)).background(.yellow).shadow(radius: 20).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 5)
                                )
                Spacer().frame(height: 5)

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
