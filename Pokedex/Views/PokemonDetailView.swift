//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Kinme on 4/23/23.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonEntry: PokemonEntry
    
    @State var pokemonSelected = PokemonSelected(sprites: PokemonSprites(), name: "", weight: 0, height: 0)
    // This doesn't get the currently active sprite
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                VStack(alignment: .center){
                    Text(" POKEMON ENTRY ").background(Color.white).frame(width: 300, height: 50) .font(.custom("GillSans", size: 28))
                        .bold()
                    
                   // Spacer()
                    
                }.fixedSize().background(Color.yellow.cornerRadius(15).frame(width: 360, height: 50).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 5)
                    
                ))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 6){
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6){
                        
                        Text(pokemonEntry.name.capitalized)
                        Text("Type: Ball")
                        Text("Height: " + String(round(Double(pokemonSelected.height) * 3.93701 )) + "\"")
                        Text("Weight: " + String(round(Double(pokemonSelected.weight) / 4.536)) + " lbs")
                    }.background(Color.white).frame(width: 300, height: 50)
                    
                    Spacer()
                }
                
                .font(.custom("GillSans", size: 25))
                .background(Color.yellow.cornerRadius(15).frame(width: 360, height: 150, alignment: .leading).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 5)
                ))
                
                .font(.custom("GillSans", size: 25))
                
                Spacer()
                
                VStack(alignment: .center){
                    //Divider()
                    Spacer()
                    if (pokemonSelected.sprites.front_default != nil) {
//                        PokemonImage(imageLink: "\(pokemonSelected.sprites.front_default)")
                        
                        AsyncImage(url: URL(string: pokemonSelected.sprites.front_default!), scale: 0.30).frame(width: 200, height: 200).scaledToFit().padding()
                    }
                    
                    Spacer()
                    
                }
                
                Spacer()

                VStack(alignment: .leading){
                    Spacer()
                    
                    
                    HStack{
                        Text("Description of the Pokeball and its details").fixedSize(horizontal: false, vertical: true)
                    }.background(Color.white).frame(width: 300, height: 50, alignment: .center)
                        .font(.custom("GillSans", size: 25))
                    
                    
                    Spacer()
                }.background(Color.yellow.cornerRadius(15).frame(width: 360, height: 200).shadow(radius: 20).scaledToFit().overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 5)
                ))
                
            }.background(Image("Grid").opacity(0.10))
        }
        .onAppear{
            getData(url: pokemonEntry.url)
        }
    }
    
    func getData(url: String){
        PokemonSelectedApi().getData(url: url){ data in
            self.pokemonSelected = data
        }
    }
}

//struct PokemonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetailView(pokemonEntry: PokemonEntry)
//    }
//}
