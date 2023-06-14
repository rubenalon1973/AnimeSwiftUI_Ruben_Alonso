//
//  AnimeTest.swift
//  AnimeSwiftUI_Prueba
//
//  Created by Ruben Alonso on 13/4/23.
//

import Foundation

struct FilePreview:FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "animeTest", withExtension: "json")!//Lleva al Json de test
    }
}

extension AnimeVM {
    static let preview = AnimeVM(persistance: Persistance(fileLocation: FilePreview()))
}

extension MyAnimeModel {
    static let test = MyAnimeModel(title: "Demon Slayer",
                                   description: "Mola que flipas",
                                   year: 2021,
                                   type: .all,
                                   rateStar: "9.8",
                                   votes: 6000,
                                   status: .enEmision,
                                   followers: 1256,
                                   episodes: 24,
                                   animeURL: "https:\\/\\/www3.animeflv.net\\/anime\\/dragon-ball-z-especial-1",
                                   image: "https:\\/\\/www3.animeflv.net\\/uploads\\/animes\\/covers\\/1115.jpg",
                                   genres: nil,
                                   isViewed: true)
}

