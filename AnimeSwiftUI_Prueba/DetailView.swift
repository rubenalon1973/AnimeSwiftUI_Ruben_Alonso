//
//  DetailView.swift
//  AnimeSwiftUI_Prueba
//
//  Created by Ruben Alonso on 16/4/23.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var vm: AnimeVM
    @State var anime: MyAnimeModel
//    @State var textComment = "write your comments"
//    @State var counter = 0

    var body: some View {
        ScrollView {
            VStack {
                //                Text(Date(), style: .date)
                //                Text(" ")
                //                + Text(Date(), style: .time)
                AsyncImage(url: URL(string: anime.image )) { image in
                    image
                        .resizable()
                        .scaledToFit()//ajusta la imagen
                        .frame(width: 300)
                        .cornerRadius(10)
                } placeholder: { //imagen provisional mientras carga la de URL
                    Image(systemName: "popcorn") //icono de la librería
                        .resizable(resizingMode: .tile)//crea patrón
                        .scaledToFit()//ajusta la imagen
                        .frame(width: 300)
                        .cornerRadius(10)
                }
                VStack {
                    Text(anime.title)
                        .font( .title)
                    //                        .shadow(color: .gray, radius: 1, x: 5 , y: 5)
                    //                    Image(systemName: "figure.kickboxing")
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .frame(width: 40)
                    //                        .foregroundColor( .blue)
                    ////                        .foregroundStyle(Color .accentColor)
                    //
                        .bold()
                    Text("\(anime.year.description) year")
                    Text("\(anime.votes.description) votes")
                    Text("\(anime.followers.description) followers")
                    //                    HStack {
                    //                        Image(systemName: "film")
                    //                            .foregroundColor( .blue)
                    Link(destination: URL(string: anime.animeURL)!){
                        Text("Navigate To episode")
                            .underline()
                    }
                    //                        Image(systemName: "film")
                    //                            .foregroundColor( .blue)
                    //                    }
                    VStack {
                        Button {
                            vm.markAsWiewd(anime: anime)
                            anime.isViewed.toggle()
                        } label: {
                            Text("MarkAsView")
                        }.buttonStyle(.bordered)
                        if anime.isViewed {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.red)
                        }
                    }
                    Text(anime.type.rawValue)
                        .bold()
                    HStack {
                        Text("Rate")
                        Text(anime.rateStar)
                        Text("star")
                    }
                    .bold()
                    VStack {
                        Text(anime.description ?? "")
                            .foregroundColor( .gray)
                    }
                }
                .bold()
                .padding()
            }
        }
    }
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            DetailView(anime: AnimeVM.preview.animes[0])
                .environmentObject(AnimeVM.preview)
        }
    }
}

