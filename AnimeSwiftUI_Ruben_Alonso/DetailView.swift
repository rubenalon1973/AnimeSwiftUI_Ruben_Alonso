//
//  DetailView.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 16/4/23.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var vm: AnimeVM
    @State var anime: MyAnimeModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: anime.image )) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .cornerRadius(10)
                } placeholder: {
                    Image(systemName: "popcorn")
                        .resizable(resizingMode: .tile)
                        .scaledToFit()
                        .frame(width: 300)
                        .cornerRadius(10)
                }
                VStack {
                    Text(anime.title)
                        .font( .title)
                        .bold()
                    Text("Premiere in \(vm.formatNumber(anime.year))")
                    Text("\(vm.formatNumber(anime.votes)) votes")
                    Text("\(vm.formatNumber(anime.followers)) followers")
                    Link(destination: URL(string: anime.animeURL)!){
                        Text("Navigate To episode")
                            .underline()
                    }
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

