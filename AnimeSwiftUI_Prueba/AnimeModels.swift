//
//  AnimeModels.swift
//  AnimeSwiftUI_Prueba
//
//  Created by Ruben Alonso on 11/4/23.
//

import Foundation

struct AnimeModel: Codable, Hashable {
    let title: String
    let description: String?
    let year: Int
    let type: String
    let rateStar: String
    let votes: Int
    let status: String
    let followers: Int
    let episodes: Int
    let animeURL: String
    let image: String
    let genres: String?
    
    //    Enum para poder cargar los parámetros con nombre sin "_"
    enum CodingKeys: String, CodingKey {
        case title, description, year, type, votes, status, followers, episodes, genres, image
        case animeURL = "url_anime"
        case rateStar = "rate_start"
    }
}

struct MyAnimeModel: Codable, Identifiable, Hashable {
    let id = UUID()//como está inicializado, no hace falta incluirlo en el enum case abajo
    let title: String
    let description: String?
    let year: Int
    let type: AnimeType
    let rateStar: String
    let votes: Int
    let status: AnimeStatus
    let followers: Int
    let episodes: Int
    let animeURL: String
    let image: String
    let genres: String?
    var isViewed: Bool
    //    Enum para poder cargar los parámetros con nombre sin "_"
    enum CodingKeys: String, CodingKey {
        case title, description, year, type, votes, status, followers, episodes, genres, image, isViewed
        case animeURL = "url_anime"
        case rateStar = "rate_start"
    }
}
//    Para agrupar y poder filtrar luego valores repetitivos de status
enum AnimeStatus:String, Codable, CaseIterable, Identifiable {
    var id: AnimeStatus { self }//buscar información
    case finalizado = "Finalizado"
    case enEmision = "En emision"
    case proximamente = "Proximamente"
    case all
}
//    Para agrupar y poder filtrar luego valores repetitivos de type
enum AnimeType:String, Codable, CaseIterable, Identifiable {
    var id: AnimeType { self }//buscar información
    case anime = "Anime"
    case special = "Especial"
    case ova = "OVA"
    case Película = "Película"
    case all
}

enum SortedBy:String, CaseIterable, Identifiable {
    var id: SortedBy { self }
    case title = "Title"
    case rate = "Rate"
    case year = "Year"
    case all
}
//propio modelo de datos
extension AnimeModel {
    func mapToModel() -> MyAnimeModel {
        return MyAnimeModel(title: title,
                            description: description,
                            year: year,
                            type: AnimeType(rawValue: type) ?? .all,//sacar opc con coalescencia nula
                            rateStar: rateStar,
                            votes: votes,
                            status: AnimeStatus(rawValue: status) ?? .all,
                            followers: followers,
                            episodes: episodes,
                            animeURL: animeURL,
                            image: image,
                            genres: genres,
                            isViewed: false)
    }
}
