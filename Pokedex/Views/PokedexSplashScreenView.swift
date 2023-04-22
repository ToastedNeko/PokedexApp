//
//  PokedexSplashScreenView.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.
//

import SwiftUI
import SSSwiftUIGIFView
import SDWebImage


struct PokedexSplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 1.00
    
    var body: some View {
        //        Color.red
        //            .ignoresSafeArea()
        //            .overlay(
        //        ZStack{
        //            //Color.red
        //               // .ignoresSafeArea()
        //
        //            VStack{
        //                SwiftUIGIFPlayerView(gifName: "AshPikachuWalk").frame(width: 200, height: 200)
        //                Text("Pokedex")
        //                //.foregroundColor(.white)
        //                    .bold()
        //                    .font(.system(size: 40))
        //            }.frame(width: 200, height: 200)
        //        }.background(Image("PokedexImage"))
        //)
        ZStack{
            ZStack{
                
                Image("PokedexCover")
                    .resizable()
                Button(action: {
                    print("Opening Pokedex")
                    
                }) {
                    HStack {
//                        Image("")
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .font(.title)
                    }
                    
                    .padding(25)
                    .shadow(radius: 10)
                    .foregroundColor(.white)
                    .background(Image("GoldTriangle").resizable().frame(width: 100, height: 100))
                    .opacity(opacity)
                    .animation(Animation.easeInOut(duration: 1.50).repeatForever(autoreverses: true)).onAppear{self.opacity = 0.3}
                    
                    
                    //.cornerRadius(20)
                }.offset(y:42)
                    .offset(x: -146)
            }.background(Color.black.ignoresSafeArea())
        }
    }
}


struct PokedexSplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexSplashScreenView()
    }
}
