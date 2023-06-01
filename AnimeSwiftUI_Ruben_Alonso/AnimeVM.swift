//
//  AnimeVM.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 13/4/23.
//

import Foundation

final class AnimeVM: ObservableObject {
    let persistance: Persistance
    
    @Published var animes: [MyAnimeModel]
    @Published var search = ""
    @Published var animeTypes: AnimeType = .all
    @Published var sortedBy: SortedBy = .all
    
    @Published var selectedTab: Int = 0
    @Published var anime: MyAnimeModel? = nil
    @Published var animeTypeFilter: AnimeType? = nil
    
    var filteredAnimes: [MyAnimeModel] {
        animes.filter { anime in
            if search.isEmpty {
                return true
            } else {
                return anime.title.lowercased().contains(search.lowercased())
            }
        }.filter { anime in
            if let filter = animeTypeFilter {
                return anime.type == filter
            } else {
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
//final class AnimeVM:ObservableObject {
//
//    let persistance:Persistance
//
//    @Published var animes:[MyAnimeModel]
//    @Published var search = ""
//    @Published var animeTypes:AnimeType = .all
//    @Published var statusTypes: AnimeStatus = .all
//    @Published var sortedBy: SortedBy = .all
//
//    var filteredAnimes:[MyAnimeModel] {
//        animes.filter { anime in
//            if search.isEmpty {                return true
//            } else {
//                return anime.title.lowercased().contains(search.lowercased())
//            }
//        }.filter { anime in
//            switch animeTypes {
//            case .anime:
//                return anime.type == .anime
//            case .special:
//                return anime.type == .special
//            case .ova:
//                return anime.type == .ova
//            case .Película:
//                return anime.type == .Película
//            case .all:
//                return true
//            }
//        }.sorted { animeOne, animeTwo in
//            switch sortedBy {
//            case .title:
//                return animeOne.title <= animeTwo.title
//            case .rate:
//                return animeOne.rateStar >= animeTwo.rateStar
//            case .year:
//                return animeOne.year >= animeTwo.year
//            case .all:
//                return true
//            }
//        }
//    }
//    init(persistance:Persistance = .shared) {
//        self.persistance = persistance
//
//        do {
//            self.animes = try persistance.loadAnimes()
//        } catch {
//            self.animes = []
//        }
//    }
    
//    func markAsWiewd(anime: MyAnimeModel) {
//        if let selectedAnimeIndex = animes.firstIndex(where: { $0.id == anime.id }) {
//            animes[selectedAnimeIndex].isViewed.toggle()
//            do {
//                try persistance.saveAnimesViewed(animes: animes)
//            } catch {
//                print(error)
//            }
//        }
//    }
//
//    func formatNumber(_ number: Int) -> String {
//            let numberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            return numberFormatter.string(from: NSNumber(value: number)) ?? ""
//        }
//}
