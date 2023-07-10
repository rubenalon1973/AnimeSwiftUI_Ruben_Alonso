//
//  ListViewedAnime.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 15/6/23.
//

import SwiftUI

struct ListViewedAnime: View {
    @EnvironmentObject var animeVM: AnimeVM
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
                Text("Animes viewed:")
                    .font(.title)
                    .bold()
            }
            .padding()
            List(animeVM.selectedAnimesViewed) { anime in
                HStack {
                    AsyncImage(url: URL(string: anime.image )) { image in
                        image
                            .resizable()
                            .frame(width: 105, height: 105)
                            .cornerRadius(10)
                            .shadow(color: .white.opacity(70.0), radius: 10.0, x: 3, y: -3)
                    } placeholder: {
                        Image(systemName: "popcorn")
                            .resizable(resizingMode: .tile)
                            .scaledToFit()
                            .frame(width: 300)
                    }
                    .padding(1.5)
                    VStack(alignment: .leading) {
                        Text(anime.title)
                            .font(.headline)
                        Text("Year: \(anime.year)")
                            .font(.subheadline)
                        Text("Rating: \(anime.rateStar)")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                }
            }.listStyle(PlainListStyle())
        }
    }
}

struct ListViewedAnime_Previews: PreviewProvider {
    static var previews: some View {
        ListViewedAnime()
            .environmentObject(AnimeVM())
            .preferredColorScheme(.dark)
    }
}
