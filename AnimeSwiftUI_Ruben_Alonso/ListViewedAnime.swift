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
        List(animeVM.selectedAnimesViewed) { anime in
            VStack(alignment: .leading) {
                Text(anime.title)
                    .font(.headline)
                Text("Year: \(anime.year)")
                    .font(.subheadline)
                Text("Rating: \(anime.rateStar)")
                    .font(.subheadline)
            }
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
