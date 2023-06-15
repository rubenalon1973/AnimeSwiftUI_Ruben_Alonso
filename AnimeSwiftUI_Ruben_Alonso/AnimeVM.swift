//
//  AnimeVM.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 13/4/23.
//

import Foundation

final class AnimeVM: ObservableObject {
    var persistance: Persistance
    
    @Published var animes: [MyAnimeModel]
    @Published var search = ""
    @Published var animeTypes: AnimeType = .all
    @Published var sortedBy: SortedBy = .all
    @Published var animesViewed: [MyAnimeModel] = []
    
    var selectedAnimesViewed: [MyAnimeModel] {
        animes.filter { $0.isViewed }
    }
    
    var filteredAnimes: [MyAnimeModel] {
        animes.filter { anime in
            if search.isEmpty {
                return true
            } else {
                return anime.title.lowercased().contains(search.lowercased())
            }
        }.filter { anime in
            switch animeTypes {
            case .anime:
                return anime.type == .anime
            case .special:
                return anime.type == .special
            case .ova:
                return anime.type == .ova
            case .pelicula:
                return anime.type == .pelicula
            case .all:
                return true
            }
        }.sorted { animeOne, animeTwo in
            switch sortedBy {
            case .title:
                return animeOne.title <= animeTwo.title
            case .rate:
                return animeOne.rateStar >= animeTwo.rateStar
            case .year:
                return animeOne.year >= animeTwo.year
            case .all:
                return true
            }
        }
    }
    
    init(persistance: Persistance = .shared) {
        self.persistance = persistance
        
        do {
            self.animes = try persistance.loadAnimes()
        } catch {
            self.animes = []
        }
    }
    
    func markAsWiewd(anime: MyAnimeModel) {
        if let selectedAnimeIndex = animes.firstIndex(where: { $0.id == anime.id }) {
            animes[selectedAnimeIndex].isViewed.toggle()
            do {
                try persistance.saveAnimesViewed(animes: animes)
                animesViewed = animes.filter { $0.isViewed }
                print("Animes Viewed: \(animesViewed)")
            } catch {
                print(error)
            }
        }
    }
    
    func formatNumber(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
}

