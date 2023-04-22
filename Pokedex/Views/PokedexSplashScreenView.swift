//
//  PokedexSplashScreenView.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.
//

/*
    This displays the splashscreen Pokedex cover
 */

import SwiftUI
import SSSwiftUIGIFView
import SDWebImage


struct PokedexSplashScreenView: View {
    @State private var showPokedex = false
    @State private var opacity = 1.00
    @State private var isAnimating = false
    
    var body: some View {
        let animation = Animation
            .easeInOut(duration: 1.30)
            .repeatForever(autoreverses: true)
        
        NavigationStack{
            NavigationLink(destination: PokedexPokemonView(), isActive: $showPokedex){
                ZStack{
                    Image("PokedexCover")
                        .resizable()
                    Button("") {
                        showPokedex = true
                        
                    }
                    .background(Image("GoldTriangle").resizable().frame(width: 100, height: 100).position(x: -145, y: 110))
                    .opacity(opacity)
                    .padding(25)
                    .shadow(radius: 10)
                    .onAppear{DispatchQueue.main.async{
                        withAnimation(animation){
                            isAnimating = true
                            self.opacity = 0.3
                        }
                    }}
                    
                }
                .background(Color.black.ignoresSafeArea())
                
            }
        }
    }
}


struct PokedexSplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexSplashScreenView()
    }
}
