//
//  AnimeVM.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 13/4/23.
//

import Foundation
//Cerebro que manda a las view
final class AnimeVM:ObservableObject { //Objeto observable desde otro sitio
    
    let persistance:Persistance //aquí tenemos guardada la class Persistance
    //    publicamos las var, y cualquier cambio de ellas dará notif para q los observadores q dependan de esta clase AnimeVM (@ObservedObject @StateObject)lo sepan y se actualicen
    @Published var animes:[MyAnimeModel]//animes es nuestro array completo
    @Published var search = ""
    @Published var animeTypes:AnimeType = .all //contiene el struct
    @Published var statusTypes: AnimeStatus = .all
    @Published var sortedBy: SortedBy = .all
    
    var filteredAnimes:[MyAnimeModel] {//var calculada
        animes.filter { anime in
            if search.isEmpty { //filter bool, true(se queda el valor), false(descarta)
                return true //dev todo el array
            } else {
                return anime.title.lowercased().contains(search.lowercased())//pasamos a min. para búsq lo coja, contains hace comprobación de q anime "contiene" search con algo
            }
        }.filter { anime in
            switch animeTypes {
            case .anime:
                return anime.type == .anime
            case .special:
                return anime.type == .special
            case .ova:
                return anime.type == .ova
            case .Película:
                return anime.type == .Película
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
    init(persistance:Persistance = .shared) {
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
            } catch {
                print(error)
            }
        }
    }
}
