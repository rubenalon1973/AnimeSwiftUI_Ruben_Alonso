//
//  Persistance.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 12/4/23.
//

import Foundation

protocol FileLocation {
    var fileURL: URL { get }
}

struct FileProduction: FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "anime", withExtension: "json")!
    }
}

final class Persistance {
    static let shared = Persistance()
    let fileLocation:FileLocation
    let favoriteDocument = URL.documentsDirectory.appending(path:  "viewedsAnime.json")
    
    init(fileLocation: FileLocation = FileProduction()) {
        self.fileLocation = fileLocation
    }
    
    func loadAnimes() throws -> [MyAnimeModel] {
        if FileManager.default.fileExists(atPath: favoriteDocument.path()) {
            let data = try Data(contentsOf: favoriteDocument)
            return try JSONDecoder().decode([MyAnimeModel].self, from: data)
        } else {
            let data = try Data(contentsOf: fileLocation.fileURL)
            let originalData = try JSONDecoder().decode([AnimeModel].self, from: data)
            let myData = originalData.map { anime in anime.mapToModel() }
            return myData
        }
    }
    
    func saveAnimesViewed(animes: [MyAnimeModel]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let saveData = try encoder.encode(animes)
        try saveData.write(to: favoriteDocument)
    }
}

